terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

# Configure the AWS Provider
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
  tags = {
      Name = "my_public_subnet"
  }
}

resource "aws_route_table_association" "rt_associate_public" {
  route_table_id = aws_default_route_table.public_rt.id
  subnet_id      = aws_subnet.my_public_subnet.id
}

resource "aws_security_group" "security_group_2" {
  name        = "security_group_2"
  description = "Testing my security group"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_server_2" {
  ami           = "ami-00463ddd1036a8eb6"
  key_name  = "cert"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_public_subnet.id
  vpc_security_group_ids = [aws_security_group.security_group_2.id]
  tags = {
    Name = "my_server_2"
  }

  # provisioner "remote-exec" {
  #   script = "/Users/meriemmounchid/Desktop/Terraform/tools/script.sh"
  #   connection {
  #     type = "ssh"
  #     host = self.public_ip
  #     user = "ubuntu"
  #     private_key = file("/Users/meriemmounchid/Desktop/Terraform/myboomi.cer")
  #   }
  # }
}