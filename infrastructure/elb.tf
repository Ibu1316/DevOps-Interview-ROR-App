resource "aws_lb" "this" {
  name               = "${var.app_name}-alb"
  load_balancer_type = "application"
  internal           = false
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.elb_sg.id]

  tags = {
    Environment = var.environment
    Project     = var.app_name
  }
}

resource "aws_security_group" "elb_sg" {
  name        = "${var.app_name}-alb-sg"
  description = "Allow inbound HTTP traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP from the world"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-alb-sg"
  }
}

resource "aws_lb_target_group" "this" {
  name        = "${var.app_name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 5
    unhealthy_threshold = 5
    matcher             = "200-399"
  }

  tags = {
    Project = var.app_name
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
 }
}
