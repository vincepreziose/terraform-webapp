data "aws_secretsmanager_secret_version" "starter_api_secret" {
  secret_id = "starter_api_secret"
}

resource "aws_rds_cluster" "starter_api_postgresql" {
  cluster_identifier = "starter-api-postgresql"
  engine             = "aurora-postgresql"
  engine_mode        = "serverless"
  availability_zones = var.availability_zones
  # Only alphanumeric characters allowed for DB name
  database_name           = var.database-name
  master_username         = local.database-credentials["username"]
  master_password         = local.database-credentials["password"]
  backup_retention_period = 1
  kms_key_id              = aws_kms_key.starter-api-postgresql.arn
  enable_http_endpoint    = true
  db_subnet_group_name    = aws_db_subnet_group.starter-api-db-subnet-group.name
  vpc_security_group_ids  = [aws_security_group.starter-api-db-security-group.id]
  scaling_configuration {
    min_capacity = 2
  }
  skip_final_snapshot = true
  apply_immediately   = true

  lifecycle {
    # RDS automatically assigns 3 AZs if less than 3 AZs are configured,
    # which will show as a difference requiring resource recreation on the next Terraform apply.
    # It is recommended to specify 3 AZs or use the lifecycle configuration block ignore_changes argument if necessary.
    ignore_changes = [availability_zones]
  }
}

resource "aws_kms_key" "starter-api-postgresql" {
  description = "Key to encrypt postgres data"
}

resource "aws_kms_alias" "starter-api-postgresql" {
  name          = "alias/starter-api-postgresql-key"
  target_key_id = aws_kms_key.starter-api-postgresql.key_id
}