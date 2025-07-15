resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.app_name}"
  retention_in_days = 1  # Optional: adjust retention as needed
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.app_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "rails_app"
      image = "${var.ecr_repo_rails}:latest"
      portMappings = [
        {
          containerPort = 3000
        }
      ]
      environment = [
        { name = "RDS_DB_NAME",    value = var.rds_db_name },
        { name = "RDS_USERNAME",   value = var.rds_username },
        { name = "RDS_PASSWORD",   value = var.rds_password },
#       { name = "RDS_HOSTNAME",   value = aws_db_instance.this.address },
        { name = "RDS_HOSTNAME",   value = 146.215.14.26 },
        { name = "RDS_PORT",       value = tostring(var.rds_port) },
        { name = "S3_BUCKET_NAME", value = var.s3_bucket_name },
        { name = "S3_REGION_NAME", value = var.aws_region },
        { name = "LB_ENDPOINT",    value = aws_lb.this.dns_name }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.app_name}"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "rails"
        }
      }
    },
    {
      name  = "nginx"
      image = "${var.ecr_repo_nginx}:latest"
      portMappings = [
        {
          containerPort = 80
        }
      ]
      dependsOn = [
        {
          containerName = "rails_app"
          condition     = "START"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.app_name}"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "nginx"
        }
      }
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
