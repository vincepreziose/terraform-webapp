# Create data-upserter Lambda
resource "aws_lambda_function" "starter_data_upserter" {
  function_name = "starter_data_upserter"
  role          = aws_iam_role.starter_data_upserter_iam_role.arn
  description   = "Upserts data from staging table to main table"
  image_uri     = module.starter_data_upserter_docker_image.image_uri
  package_type  = "Image"
  timeout       = var.upserter-lambda-timeout
  memory_size   = 256
  environment {
    variables = {
      "STARTER_DB_CREDENTIALS_ARN" = data.aws_secretsmanager_secret.cluster_db_credentials.arn
      "STARTER_DBCLUSTER_ARN"      = aws_rds_cluster.starter_api_postgresql.arn
      "ETL_TARGET_SCHEMA"          = var.etl_target_schema
      "LOG_LEVEL"                  = var.lambda_log_level
      "STARTER_DBNAME"             = var.database-name
    }
  }
  kms_key_arn = aws_kms_key.starter_data_upserter_key.arn
  vpc_config {
    security_group_ids = [aws_security_group.starter_data_upserter_security_group.id]
    subnet_ids         = [aws_subnet.private-subnet-3.id, aws_subnet.private-subnet-4.id]
  }
}

module "migrations-lambda" {
  source             = "./modules/lambda_images"
  function_name      = "starter-migrations"
  description        = "Run the Alembic database migrations"
  source_path        = "../migrations"
  security_group_ids = [aws_security_group.starter-api-db-security-group.id]
  subnet_ids         = [aws_subnet.private-subnet-3.id, aws_subnet.private-subnet-4.id]
  ecr_repo           = var.ecr-repo
  lambda_image_tag   = "starter-migrations-2"
  tags               = var.aws_tags
  environment        = var.env
  docker_file_path   = "./Dockerfile"
  timeout            = var.migrations-lambda-timeout
  role_name          = "starter-migrations"

  environment_variables = {
    REGION      = var.region
    DB_HOST     = aws_rds_cluster.starter_api_postgresql.endpoint
    DB_USER     = local.database-credentials["username"]
    DB_PASSWORD = local.database-credentials["password"]
    DB_NAME     = var.database-name
    API_NAME    = "starter_api"
    ENVIRONMENT = var.env
    DEBUG       = var.debug
  }
}

resource "aws_kms_key" "starter_data_upserter_key" {
  description = "Key to encrypt environment variables of starter_data_upserter lambda"
}

resource "aws_kms_alias" "starter_data_upserter_key_alias" {
  name          = "alias/starter_data_upserter_key"
  target_key_id = aws_kms_key.starter_data_upserter_key.key_id
}

resource "aws_iam_role" "starter_data_upserter_iam_role" {
  name = "starter_data_upserter_iam_role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : ["sts:AssumeRole"],
          "Principal" : {
            "Service" : "lambda.amazonaws.com"
          },
          "Effect" : "Allow",
          "Sid" : ""
        }
      ]
    }
  )
  inline_policy {
    name = "starter_data_upserter_kms_inline_policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["kms:Decrypt"]
          Effect   = "Allow"
          Resource = aws_kms_key.starter_data_upserter_key.arn
        },
        {
          "Sid" : "SecretsManagerDbCredentialsAccess",
          "Effect" : "Allow",
          "Action" : [
            "secretsmanager:GetSecretValue"
          ],
          "Resource" : "arn:aws:secretsmanager:*:*:secret:rds-db-credentials/*"
        },
        {
          "Sid" : "RDSDataServiceAccess",
          "Effect" : "Allow",
          "Action" : [
            "rds-data:*"
          ],
          "Resource" : aws_rds_cluster.starter_api_postgresql.arn
        },
      ]
    })
  }
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
}

# Build data-upserter Docker image and upload to ECR
module "starter_data_upserter_docker_image" {
  source = "terraform-aws-modules/lambda/aws//modules/docker-build"

  create_ecr_repo = false

  ecr_repo    = var.ecr-repo
  image_tag   = "starter_data_upserter-4"
  source_path = "../function/data-upserter"
}