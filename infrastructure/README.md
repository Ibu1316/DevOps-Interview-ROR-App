- Custom VPC with public and private subnets
- Internet Gateway and NAT Gateway for network access
- Application Load Balancer (ALB) in public subnet
- ECS Cluster (Fargate) with:
  - Rails App container
  - Nginx proxy container
- RDS (PostgreSQL 13.3) in private subnet
- S3 Bucket for file storage
- IAM roles for ECS task execution and S3 access
- S3 backend for Terraform remote state with DynamoDB state locking
- GitHub Actions workflow with OIDC to securely deploy Terraform

--------------------Project Structure------------------------------
├── .github/workflows/
│ └── terraform-deploy.yml # CI/CD pipeline for Terraform
├── infrastructure/
│ ├── vpc.tf # Networking
│ ├── ecs.tf # ECS Cluster, Task Definition & Service
│ ├── rds.tf # RDS PostgreSQL instance
│ ├── iam.tf # IAM roles & policies
│ ├── elb.tf # ALB setup
│ ├── s3.tf # S3 bucket
│ ├── backend.tf # Terraform remote state config
│ ├── variables.tf # Input variables
│ ├── outputs.tf # Output values
│ └── terraform.tfvars # Variable values
