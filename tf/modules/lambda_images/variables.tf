variable "ecr_repo" {
  type = string
}

variable "lambda_image_tag" {
  type = string
}

variable "function_name" {
  type = string
}

variable "description" {
  type = string
}

variable "role_name" {
  type = string
}

variable "source_path" {
  type = string
}

variable "security_group_id" {
  type    = string
  default = ""
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "environment_variables" {
  type    = map(any)
  default = {}
}

variable "api_integration_type" {
  type    = string
  default = "AWS_PROXY"
}

variable "tags" {
  type = map(any)
}

variable "environment" {
  type = string
}

variable "gateway_exec_arn" {
  type    = string
  default = ""
}

variable "timeout" {
  type    = number
  default = 3
}

variable "create_ecr_repo" {
  type    = bool
  default = false
}

variable "api_gateway_enabled" {
  type    = bool
  default = false
}

variable "allowed_triggers" {
  type    = map(any)
  default = {}
}

variable "docker_file_path" {
  description = "Path to Dockerfile in source package"
  type        = string
}

variable "attach_policy" {
  type    = bool
  default = false
}

variable "policy" {
  type    = string
  default = ""
}

variable "cloudwatch_log_retention_in_days" {
  type    = number
  default = 7
}
