resource "aws_db_subnet_group" "this" {
  name       = "${var.app_name}-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name        = "${var.app_name}-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.app_name}-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "13.3"
  instance_class          = "db.t3.micro"
  name                    = var.rds_db_name
  username                = var.rds_username
  password                = var.rds_password
  port                    = var.rds_port
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
 }
}
