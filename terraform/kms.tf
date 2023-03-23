# resource "aws_kms_key" "my_key" {
#     description = "KMS key for Data Encryption"
# }

# resource "aws_db_parameter_group" "my_parameter_group" {
#   name        = "my-db-parameter-group"
#   family      = "mariadb10.6.10"
#   description = "My database parameter group"

#   parameter {
#     name  = "key-demo"
#     value = aws_kms_key.my_key.arn
#   }
# }

# resource "aws_secretsmanager_secret" "my_secret" {
#   name        = "my_secret"
#   description = "My sensitive information"
# }

# resource "aws_secretsmanager_secret_version" "my_secret_value" {
#   secret_id     = aws_secretsmanager_secret.my_secret.id
#   secret_string = "my_secret_value"
# }

# resource "aws_secretsmanager_secret_version" "my_secret_value" {
#   secret_id     = aws_secretsmanager_secret.my_secret.id
#   secret_string = file("/Users/meriemmounchid/Desktop/Terraform/ec2-instance/terraform/templates/db-creds.yml")
# }

# data "aws_secretsmanager_secret_version" "my_secret_value" {
#   secret_id = aws_secretsmanager_secret.my_secret.id
# }

# output "my_secret_value" {
#   value = data.aws_secretsmanager_secret_version.my_secret_value.secret_string
# }