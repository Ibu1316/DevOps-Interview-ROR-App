aws_region  = "us-east-1"
app_name    = "ror-app"
environment = "dev"
rds_db_name     = "devopsappdb"
rds_username    = "devdbuser"
rds_password    = "Nopass#542165"
rds_port        = 5432
ecr_repo_nginx = "536697233234.dkr.ecr.us-east-1.amazonaws.com/devops/nginx-proxy"
ecr_repo_rails = "536697233234.dkr.ecr.us-east-1.amazonaws.com/devops/rails-app"
public_subnets  = ["146.215.14.128/28", "146.215.14.144/28"]
s3_bucket_name = "devops-app-storage-bucket-ror"

