resource "aws_db_subnet_group" "rds-subnet" {
  name        = "rds-subnet-group"
  description = "Subnet group for RDS instance"
  subnet_ids  = [aws_subnet.my_rds_subnet1.id, aws_subnet.my_rds_subnet2.id]

  tags = {
    Name = "rds-subnet"
  }
}

resource "aws_db_instance" "rds_db" {
  identifier           = "rds-db"
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mariadb"
  engine_version       = "10.6.10"
  instance_class       = "db.t2.micro"
  username             = "myuser"
  # password             = "mypassword"
  password  = aws_secretsmanager_secret_version.my_secret_value.secret_string

  parameter_group_name = "default.mariadb10.6"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds-subnet.name

  # kms_key_id            = data.aws_kms_key.key-demo.arn
  tags = {
    Name = "rds_db"
  }
}