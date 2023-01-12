module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = "main"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  # enable_vpn_gateway = true

  tags = {
    # Terraform = "true"
    # Environment = "dev"
    Environment = "staging"
  }
}