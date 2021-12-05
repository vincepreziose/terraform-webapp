resource "aws_ecr_repository" "lets_chat" {
  name                 = var.lets_chat_ecr_repo
  image_tag_mutability = "MUTABLE"
}