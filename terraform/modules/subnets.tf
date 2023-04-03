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
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"
  tags = {
      Name = "my_public_subnet2"
  }
}

resource "aws_subnet" "my_rds_subnet1" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = "eu-west-1a"
  tags = {
      Name = "my_rds_subnet1"
  }
}

resource "aws_subnet" "my_rds_subnet2" {
  cidr_block = "10.0.4.0/24"
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = "eu-west-1c"
  tags = {
      Name = "my_rds_subnet2"
  }
}