module "application_network" {
  source      = "../../common-modules/network-multi-az"
  cidr_block  = "10.0.0.0/16"
  environment = var.environment
}

resource "aws_security_group" "alb_sg" {
  name_prefix = "${var.environment}-alb-sg"
  vpc_id      = module.application_network.vpc_id

  ingress {
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
    Name = "${var.environment}-alb-sg"
  }
}

resource "aws_lb" "app_lb" {
  name               = "${var.environment}-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.application_network.public_subnet_ids

  tags = {
    Name = "${var.environment}-app-lb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "${var.environment}-app-tg"
  port     = 4000
  protocol = "HTTP"
  vpc_id   = module.application_network.vpc_id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "${var.environment}-app-tg"
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

module "application_asg" {
  source                 = "../../common-modules/asg"
  environment            = var.environment
  vpc_id                 = module.application_network.vpc_id
  private_subnet_ids     = module.application_network.private_subnet_ids
  key_name               = var.key_name
  alb_security_group_id  = aws_security_group.alb_sg.id
  target_group_arn       = aws_lb_target_group.app_tg.arn
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = var.desired_capacity
}
