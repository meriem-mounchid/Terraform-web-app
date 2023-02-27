# resource "aws_eip" "my_eip" {
#   vpc = true
  
#   tags = {
#       Name = "my_eip"
#   }
# }


# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.my_eip.id
#   subnet_id = aws_subnet.my_public_subnet.id

#   tags = {
#       Name = "my_nat"
#   }

#   depends_on = [aws_internet_gateway.igw]
# }
