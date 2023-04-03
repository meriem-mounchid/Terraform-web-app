### EC2 ###
resource "aws_instance" "my_1st_server" {
  ami       = "ami-00463ddd1036a8eb6"
  key_name  = "cert"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_public_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data = templatefile("${path.module}/templates/instance.tpl",{
    db_endpoint = aws_db_instance.rds_db.endpoint,
    lb_name = aws_lb.alb.dns_name,
    password = var.db_password,
    db_name = var.db_name,
    db_user = var.db_user,
    wp_password = var.wp_password,
    wp_user = var.wp_user
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
  user_data = templatefile("${path.module}/templates/instance.tpl",{
    db_endpoint = aws_db_instance.rds_db.endpoint,
    lb_name = aws_lb.alb.dns_name,
    password = var.db_password,
    db_name = var.db_name,
    db_user = var.db_user,
    wp_password = var.wp_password,
    wp_user = var.wp_user
  })
  tags = {
    Name = "my_2nd_server"
  }
}

resource "null_resource" "example" {
  connection {
    type        = "ssh"
    host        = aws_instance.my_1st_server.public_ip
    user        = "ubuntu"
    private_key = file("../../keys/cert.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo echo hello world 2 >> ~/test.sh",
      "echo $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4) >> ~/test.sh"
    ]
  }
}
