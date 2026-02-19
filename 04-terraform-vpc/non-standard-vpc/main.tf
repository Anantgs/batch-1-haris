data "aws_availability_zones" "example" {
  all_availability_zones = true

  filter {
    name   = "opt-in-status"
    values = ["not-opted-in", "opted-in"]
  }
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
  region = var.aws_region

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  create_igw = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }

}

output "azs" {
  value = data.aws_availability_zones.example
}

