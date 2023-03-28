resource "aws_secretsmanager_secret" "rds-secret" {
  name = "my-rds-secret3"
  description = "My secret description"
  kms_key_id = "arn:aws:kms:eu-west-1:434046751222:key/a2ecedb4-22af-424f-b87e-ff9386729cae"
}

resource "aws_secretsmanager_secret_version" "my_secret_value" {
  secret_id     = aws_secretsmanager_secret.rds-secret.id
  secret_string = "mypassword"
}