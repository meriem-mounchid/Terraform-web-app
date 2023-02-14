provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
  tags = {
      Name = "Test-Vpc-2"
      Name = var.vpc_name
  }
}

variable "vpc_name" {
  type = string
  default     = "My-Test-Vpc-3"
}

output "vpc_id" {
  value = aws_vpc.test.id
}