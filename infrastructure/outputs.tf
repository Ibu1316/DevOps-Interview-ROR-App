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

