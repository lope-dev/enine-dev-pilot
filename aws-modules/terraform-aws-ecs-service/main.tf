terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7"
    }
  }
}



#This data source an its associated depends_on statement may be needed for ALB ordering
# Uncomment if so

/*
data "aws_alb" "lb" {
 arn = var.lb_arn
}
*/
/*
Service discovery service
*/

/*
resource "aws_service_discovery_service" "service" {
  count = var.create_discovery_record ? 1 : 0
  name = var.sd_record_name
  dns_config {
    namespace_id = var.namespace_id
    dns_records {
      ttl  = "60"
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }
  health_check_custom_config {
    failure_threshold = "1"
  }
}
*/

/*
ECS Service
*/

resource "aws_ecs_service" "main" {
  name            = "${var.resource_prefix}-${var.container_name}-ecs-service"
  cluster         = var.ecs_cluster_id
  task_definition = var.ecs_task_definition_arn
  desired_count   = var.task_count
  launch_type     = "FARGATE"
  platform_version = "1.4.0"
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  network_configuration {
    security_groups = var.ecs_security_groups
    subnets         = var.alb_subnets_private
    assign_public_ip = false
  }

   dynamic "load_balancer" {
    for_each = var.load_balancers
    content {
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
      elb_name         = lookup(load_balancer.value, "elb_name", null)
      target_group_arn = lookup(load_balancer.value, "target_group_arn", null)
    }
  }

   dynamic "service_registries" {
    for_each = var.service_registries
    content {
      registry_arn   = service_registries.value.registry_arn
      container_name = lookup(service_registries.value, "container_name", null)
      container_port = lookup(service_registries.value, "container_port", null)
    }
  }



  tags = local.tags

  #depends_on = [data.aws_alb.lb]
}

#Auto Scaling 



resource "aws_appautoscaling_target" "ecs_target" {
  count = var.enable_autoscaling ? 1 : 0
  max_capacity       = var.ecs_max_capacity
  min_capacity       = var.ecs_min_capacity
  resource_id        = "service/${var.ecs_cluster_id}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "cpu_policy" {
  count = var.enable_autoscaling ? 1 : 0
  name               = "${var.app_name}-${var.environment}-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value     = var.cpu_threshold
    disable_scale_in = var.disable_scale_in

    customized_metric_specification {
      metric_name = "CPUReservation"
      namespace   = "AWS/ECS"
      statistic   = var.cpu_statistic

      dimensions {
        name  = "ClusterName"
        value = var.ecs_cluster_id
      }
    }
  }
}




