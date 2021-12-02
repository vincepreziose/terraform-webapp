locals {
  current-time = timestamp()

  database-credentials = jsondecode(
    data.aws_secretsmanager_secret_version.starter_api_secret.secret_string
  )
}