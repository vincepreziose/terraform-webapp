module "lets-chat-lambda" {
  source             = "./modules/lambda_images"
  function_name      = "lets-chat"
  description        = "Handle Lets Chat requests from Mighty Real Website"
  source_path        = "../function/lets_chat"
  security_group_ids = [aws_security_group.lets-chat-lambda-sg.id]
  subnet_ids         = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  ecr_repo           = var.lets-chat-ecr-repo
  lambda_image_tag   = "lets-chat-1"
  tags               = var.aws_tags
  environment        = var.env
  docker_file_path   = "./Dockerfile"
  timeout            = var.lets-chat-lambda-timeout
  role_name          = "lets-chat-lambda-role"

  environment_variables = {
    FOO = "bar"
  }
}