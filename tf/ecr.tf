resource "aws_ecr_repository" "starter_api" {
  name                 = var.ecr-repo
  image_tag_mutability = "IMMUTABLE"
}