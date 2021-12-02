resource "aws_ecr_repository" "lets-chat" {
  name                 = var.lets-chat-ecr-repo
  image_tag_mutability = "MUTABLE"
}