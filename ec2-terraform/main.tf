terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "my_vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
       Name = "my_vpc"
   }
}

resource "aws_internet_gateway" "igw"{
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_default_route_table" "public_rt" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id
}

resource "aws_route" "public_route_gateway" {
  route_table_id = aws_default_route_table.public_rt.id

  depends_on = [
    aws_default_route_table.public_rt,
  ]

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_subnet" "my_public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
  tags = {
      Name = "my_public_subnet"
  }
}

resource "aws_subnet" "my_public_subnet2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.100.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"
  tags = {
      Name = "my_public_subnet2"
  }
}

resource "aws_route_table_association" "rt_associate_public" {
  route_table_id = aws_default_route_table.public_rt.id
  subnet_id      = aws_subnet.my_public_subnet.id
}

resource "aws_route_table_association" "rt_associate_public2" {
  route_table_id = aws_default_route_table.public_rt.id
  subnet_id      = aws_subnet.my_public_subnet2.id
}

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Testing my security group"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_1st_server" {
  ami       = "ami-00463ddd1036a8eb6"
  key_name  = "cert"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_public_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data = file("script.sh")
  tags = {
    Name = "my_1st_server"
  }
}

# output "debug" {
#   value = join("", ["http://", aws_instance.my_1st_server.public_ip])
# }

resource "aws_instance" "my_2nd_server" {
  ami       = "ami-00463ddd1036a8eb6"
  key_name  = "cert"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_public_subnet2.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data = file("script.sh")
  tags = {
    Name = "my_2nd_server"
  }
}

resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  subnets = [aws_subnet.my_public_subnet.id, aws_subnet.my_public_subnet2.id]
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "albtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

resource "aws_lb_target_group_attachment" "alb_tga1" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.my_1st_server.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb_tga2" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.my_2nd_server.id
  port             = 80
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    type             = "forward"
  }
}