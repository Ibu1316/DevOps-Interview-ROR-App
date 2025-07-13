output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.id
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "rds_hostname" {
  description = "The endpoint of the RDS PostgreSQL instance"
  value       = aws_db_instance.this.endpoint
}

output "lb_endpoint" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.this.dns_name
}


