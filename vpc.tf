locals {
  tags = {
    Owner       = "Gartner"
    Environment = "${var.env}"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = "gartner-db"
  cidr = "172.16.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  azs              = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets   = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  private_subnets  = ["172.16.11.0/24", "172.16.12.0/24", "172.16.13.0/24"]
  database_subnets = ["172.16.21.0/24", "172.16.22.0/24", "172.16.23.0/24"]

  tags = local.tags
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "${var.app_name}db-sg-${var.env}"
  description = "Security group for application backend service and ops team"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  ingress_with_cidr_blocks = [
    {
      rule        = "mysql-tcp"
      description = "Backend instances subnets"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "mysql-tcp"
      description = "Ops vpn access"
      cidr_blocks = "192.168.1.0/24"
    },
  ]
}

