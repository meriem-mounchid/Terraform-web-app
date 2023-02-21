resource "aws_vpc" "my_vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
       Name = "my_vpc"
   }
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