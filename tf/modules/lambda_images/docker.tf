# Build get-data Docker image and upload to ECR
module "lambda_docker_image" {
  source           = "terraform-aws-modules/lambda/aws//modules/docker-build"
  version          = "2.7.0"
  create_ecr_repo  = false
  ecr_repo         = var.ecr_repo
  image_tag        = var.lambda_image_tag
  source_path      = var.source_path
  docker_file_path = var.docker_file_path
}
