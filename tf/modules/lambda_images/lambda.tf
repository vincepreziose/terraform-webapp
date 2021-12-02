module "lambda_function_from_container_image" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "2.5.0"
  function_name                     = var.function_name
  description                       = var.description
  create_package                    = false
  build_in_docker                   = true
  cloudwatch_logs_retention_in_days = var.cloudwatch_log_retention_in_days
  attach_cloudwatch_logs_policy     = true
  attach_network_policy             = true
  role_name                         = var.role_name

  ##################
  # Container Image
  ##################
  image_uri              = module.lambda_docker_image.image_uri
  package_type           = "Image"
  timeout                = var.timeout
  vpc_subnet_ids         = var.subnet_ids
  vpc_security_group_ids = var.security_group_ids
  environment_variables  = var.environment_variables
}
