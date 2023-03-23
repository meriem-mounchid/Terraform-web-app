output "instance_ip" {
  value = aws_instance.my_1st_server.public_ip
}

output "instance_ip2" {
  value = aws_instance.my_2nd_server.public_ip
}

output "lb_name" {
  value = aws_lb.alb.dns_name
}

output "rds-name" {
  value = aws_db_instance.rds_db.identifier
}

output "my_secret_arn" {
  value = aws_secretsmanager_secret.rds-secret.arn
}

output "my_rds_instance_endpoint" {
  value = aws_db_instance.rds_db.endpoint
}