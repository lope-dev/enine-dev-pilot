#------------------------------------------------------------------------------
# ECS Task Definition
#------------------------------------------------------------------------------


#Get the execution context from Terraform
data "aws_caller_identity" "current" {}

# Container definition template
/*
data "template_file" "container_definitions" {
  template = file("task-definitions/${var.task_name}.json")
  vars = var.container_definition_vars
}
*/

# Task Definition
resource "aws_ecs_task_definition" "td" {
  family                = "${var.task_name}-${var.environment_name}-task-definition"
  container_definitions = templatefile("task-definitions/${var.task_name}.json", var.container_definition_vars )   #data.template_file.container_definitions.rendered
  task_role_arn         = var.task_role_arn
  execution_role_arn    = var.execution_role_arn
  network_mode          = var.network_mode #"awsvpc"
  tags = local.tags

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      expression = lookup(placement_constraints.value, "expression", null)
      type       = placement_constraints.value.type
    }
  }

  cpu                      = var.container_cpu
  memory                   = var.container_memory
  requires_compatibilities = ["FARGATE"]
  
  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration
    content {
      container_name = proxy_configuration.value.container_name
      properties     = lookup(proxy_configuration.value, "properties", null)
      type           = lookup(proxy_configuration.value, "type", null)
    }
  }


   dynamic "volume" {
    for_each = var.volume
    content {
      name      = volume.value.name
      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          scope         = lookup(docker_volume_configuration.value, "scope", null)
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])
        content {
          file_system_id          = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", null)
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", null)

          dynamic "authorization_config" {
            for_each = length(lookup(efs_volume_configuration.value, "authorization_config")) == 0 ? [] : [lookup(efs_volume_configuration.value, "authorization_config", {})]
            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }





}
