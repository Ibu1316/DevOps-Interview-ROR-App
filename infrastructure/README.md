# Infrastructure Setup for Ruby on Rails App on AWS ECS
This Terraform code provisions:
- A new VPC
- NAT gateway for outbound access
- ECS Cluster (Fargate)
- ALB (in public subnet)
- RDS Postgres 13.3
- S3 bucket
- IAM roles for ECS and S3 access
