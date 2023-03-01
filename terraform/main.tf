### EC2 ###
resource "aws_instance" "my_1st_server" {
  ami       = "ami-00463ddd1036a8eb6"
  key_name  = "cert"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_public_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  # user_data = file("script.sh")
  user_data = templatefile("${path.module}/templates/instance.tpl",{
    db_endpoint = aws_db_instance.rds_db.endpoint,
    lb_name = aws_lb.alb.name
  })
  tags = {
    Name = "my_1st_server"
  }
}

resource "aws_instance" "my_2nd_server" {
  ami       = "ami-00463ddd1036a8eb6"
  key_name  = "cert"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_public_subnet2.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  # user_data = file("script.sh")
  user_data = templatefile("${path.module}/templates/instance.tpl",{
    db_endpoint = aws_db_instance.rds_db.endpoint,
    lb_name = aws_lb.alb.dns_name
  })
  tags = {
    Name = "my_2nd_server"
  }
}