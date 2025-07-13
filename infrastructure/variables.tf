variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "Devops-app"
}

variable "environment" {
  default = "dev"
}

variable "s3_bucket_name" {
  default = "Devops-app-storage-bucket"
}

variable "ecr_repo_rails" {}
variable "ecr_repo_nginx" {}
variable "rds_db_name" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_hostname" {}
variable "rds_port" {}
variable "lb_endpoint" {}
