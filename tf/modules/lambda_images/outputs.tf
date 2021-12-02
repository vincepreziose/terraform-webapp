output "this_lambda_function_arn" {
  description = "ARN of the lambda"
  value       = module.lambda_function_from_container_image.lambda_function_arn
}

output "lambda_cloudwatch_log_group_arn" {
  description = "ARN of the lambda cloudwatch log group"
  value       = module.lambda_function_from_container_image.lambda_cloudwatch_log_group_arn
}

output "function_name" {
  description = "Function name of the lambda"
  value       = module.lambda_function_from_container_image.lambda_function_name
}

output "lambda_function_invoke_arn" {
  description = "Lambda invocation ARN"
  value       = module.lambda_function_from_container_image.lambda_function_invoke_arn
}

output "lambda_function_role_name" {
  description = "Lambda role"
  value       = module.lambda_function_from_container_image.lambda_role_name
}
