resource "aws_secretsmanager_secret" "rds-secret" {
  name = "my-rds-secret2"
  description = "My secret description"
  kms_key_id = "arn:aws:kms:eu-west-1:434046751222:key/a2ecedb4-22af-424f-b87e-ff9386729cae"
}

# data "aws_secretsmanager_secret_version" "rds-secret-version" {
#   secret_id = aws_secretsmanager_secret.rds-secret.id
#   version_stage = "AWSCURRENT"
# #   secret_string = <<EOF
# #   {
# #     "Username": "${aws_db_instance.rds_db.username}"
# #   }
# #   EOF
# }

resource "aws_secretsmanager_secret_version" "my_secret_value" {
  secret_id     = aws_secretsmanager_secret.rds-secret.id
  secret_string = "my_secret_value"
}

# resource "aws_secretsmanager_secret_policy" "rds-policy" {
#   secret_arn     = ""
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect   = "Allow"
#         Principal = {
#           Service = "rds.amazonaws.com"
#         }
#         Action = [
#           "secretsmanager:GetSecretValue"
#         ]
#         Resource = aws_secretsmanager_secret.rds-secret.arn
#       }
#     ]
#   })
# }
