output "example" {
  value = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["rds_master_user"]
  sensitive = true

}