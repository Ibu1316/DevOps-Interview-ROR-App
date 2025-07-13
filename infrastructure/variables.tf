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

variable "ecr_repo_rails" {
  description = "536697233234.dkr.ecr.us-east-1.amazonaws.com/devops/rails-app"
  type        = string
}

variable "ecr_repo_nginx" {
  description = "536697233234.dkr.ecr.us-east-1.amazonaws.com/devops/nginx-proxy"
  type        = string
}

variable "rds_db_name" {
  description = "devdb"
  type        = string
}

variable "rds_username" {
  description = "devuser"
  type        = string
}

variable "rds_password" {
  description = "Nopass@145214"
  type        = string
  sensitive   = true
}

variable "rds_hostname" {
  description = "RDS endpoint hostname"
  type        = string
}

variable "rds_port" {
  description = "Port number for the RDS PostgreSQL database"
  type        = number
  default     = 5432
}

variable "lb_endpoint" {
  description = "DNS endpoint of the Load Balancer (without http)"
  type        = string
}



