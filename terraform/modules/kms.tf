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
# data "aws_kms_key" "my_key" {
#   key_id = "a2ecedb4-22af-424f-b87e-ff9386729cae"
# }

# data "aws_kms_ciphertext" "testing_tfvars_encrypted" {
#   plaintext = filebase64("./testing.tfvars")
#   key_id    = data.aws_kms_key.my_key.key_id
# }