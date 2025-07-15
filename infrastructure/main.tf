provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "devops-ror-app-tfstate-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true
  }
}
