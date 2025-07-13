resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.app_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "512"
  memory                  = "1024"
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn           = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "rails_app",
      image = "${var.ecr_repo_rails}:latest",
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ],
      environment = [
        { name = "RDS_DB_NAME",       value = var.rds_db_name },
        { name = "RDS_USERNAME",      value = var.rds_username },
        { name = "RDS_PASSWORD",      value = var.rds_password },
        { name = "RDS_HOSTNAME",      value = var.rds_hostname },
        { name = "RDS_PORT",          value = var.rds_port },
        { name = "S3_BUCKET_NAME",    value = var.s3_bucket_name },
        { name = "S3_REGION_NAME",    value = var.aws_region },
        { name = "LB_ENDPOINT",       value = var.lb_endpoint }
      ]
    },
    {
      name  = "nginx",
      image = "${var.ecr_repo_nginx}:latest",
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ],
      links = ["rails_app"]
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.this.id
  launch_type     = "FARGATE"
  desired_count   = 2
  task_definition = aws_ecs_task_definition.this.arn

  network_configuration {
    subnets          = module.vpc.private_subnets
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.this]
}
