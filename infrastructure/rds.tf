resource "aws_db_subnet_group" "this" {
  name       = "${var.app_name}-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name        = "${var.app_name}-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.app_name}-rds-sg"
  description = "Allow ECS tasks to connect to RDS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id] # make sure this SG is defined elsewhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-rds-sg"
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.app_name}-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "13"
  instance_class          = "db.t3.micro"
  username                = var.rds_username
  password                = var.rds_password
  port                    = var.rds_port
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id] # ✅ This line was missing
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false
  deletion_protection     = false

  tags = {
    Name        = "${var.app_name}-rds"
    Environment = var.environment
  }
}
