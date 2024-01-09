terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7"
    }
  }
}

// Data Sources
#Trigger 1
// Resources

/*
resource "aws_security_group" "gh" {
  // Produces an AWS Security Group.
  name        = "${var.project}-${var.environment}-${var.name}-sg"
  description = var.description
  vpc_id      = var.vpc_id
  tags = local.tags
}
*/

resource "aws_lb" "gh" {
  // Produces an AWS Application Load Balancer.
  name               = "${var.app_name}-${var.environment}-alb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = local.tags
}

resource "aws_lb_target_group" "gh" {
  // Produces an AWS Application Load Balancer Target Group.
  name        = "${var.app_name}-${var.environment}-tg"
  target_type = var.target_type
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  health_check {
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher             = var.health_check_matcher
  }
  tags = local.tags

}


resource "aws_lb_listener" "gh" {
  // Produces an AWS Application Load Balancer Listener.
  load_balancer_arn = aws_lb.gh.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.action
    target_group_arn = aws_lb_target_group.gh.arn
  }
}
