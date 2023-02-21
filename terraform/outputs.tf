output "instance_ip" {
  value = aws_instance.my_1st_server.public_ip
}

output "instance_ip2" {
  value = aws_instance.my_2nd_server.public_ip
}