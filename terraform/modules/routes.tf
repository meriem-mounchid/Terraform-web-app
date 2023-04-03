resource "aws_default_route_table" "public_rt" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id
  tags = {
    Name = "public_rt"
  }
}

resource "aws_route" "public_route_gateway" {
  route_table_id = aws_default_route_table.public_rt.id

  depends_on = [
    aws_default_route_table.public_rt,
  ]

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "rt_associate_public" {
  route_table_id = aws_default_route_table.public_rt.id
  subnet_id      = aws_subnet.my_public_subnet.id
}

resource "aws_route_table_association" "rt_associate_public2" {
  route_table_id = aws_default_route_table.public_rt.id
  subnet_id      = aws_subnet.my_public_subnet2.id
}

# resource "aws_route_table" "private_rt" {
#   vpc_id = aws_vpc.my_vpc.default_route_table_id
#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat.id
#   }

#   tags = {
#     Name = "private_rt"
#   }
# }

# resource "aws_route_table_association" "rt_associate_private" {
#   route_table_id = aws_route_table.private_rt.id
#   subnet_id      = aws_subnet.private_1.id
# }

# resource "aws_route_table_association" "rt_associate_private2" {
#   route_table_id = aws_route_table.private_rt.id
#   subnet_id      = aws_subnet.private_2.id
# }