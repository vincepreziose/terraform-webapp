module "lets_chat" {
  source             = "./modules/lambda_images"
  function_name      = "lets-chat"
  description        = "Handle Lets Chat requests from Mighty Real Website"
  source_path        = "../function/lets_chat"
  security_group_ids = [aws_security_group.wide_open_sg.id]
  subnet_ids         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  ecr_repo           = var.lets_chat_ecr_repo
  lambda_image_tag   = "lets-chat-1"
  tags               = var.aws_tags
  environment        = var.env
  docker_file_path   = "./Dockerfile"
  timeout            = var.lets_chat_lambda_timeout
  role_name          = "lets-chat-lambda-role"

  environment_variables = {
    FOO = "bar"
  }
}