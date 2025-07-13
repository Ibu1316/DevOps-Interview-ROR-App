module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = "${var.app_name}-vpc"
  cidr = "146.215.14.0/24"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["146.215.14.0/28", "146.215.14.16/28"]

  enable_nat_gateway     = true
  enable_dns_hostnames   = true
  enable_dns_support     = true
  single_nat_gateway     = true
  create_igw             = true

  tags = {
    Project     = var.app_name
    Environment = var.environment
  }
}
