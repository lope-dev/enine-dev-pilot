
variable "app_name" {
  type        = string
  description = "The applcation name (used in naming)"
  default     = "app-name"
}

variable "environment" {
  type        = string
  description = "The applcation environment name (used in naming)"
  default     = "dev"
}


variable "resource_prefix" {
  type        = string
  description = "Naming prefix to use for resources to be provisioned"
  default     = "thmb-gen"
}

variable "ecs_cluster_id" {
  type        = string
  description = "Only needed if enable_monitoring = 1"
  default     = ""
}

variable "ecs_task_definition_arn" {
  type        = string
  description = "ARN of ECS task definition to use with service"
}

variable "namespace_id" {
  type = string
  default = null
}



variable "container_name" {
  type = string
  description = "The name of the load balanced container"
}

variable "task_count" {
  type    = string
  default = 1
}

variable "alb_subnets_private" {
  type        = list(string)
  description = "List of Ids of subnets in which load balancer will be hosted if alb_internal = true. App will be hosted in private subnets."
}

variable "ecs_security_groups" {
  type        = list(string)
  description = "List of ecs security groups to apply to the ecs service"
}

#variable "alb_subnets_public" {
#  type        = list(string)
#  description = "List of Ids of subnets in which load balancer will be hosted if alb_internal = false"
#}

variable "alb_listener_default_redirect_host" {
  type        = string
  description = "Host to which request will be redirected (only used if alb_listener_default_action is redirect)"
  default     = "#{host}"
}

variable "app_port" {
  type    = string
  default = 443
}

variable "health_check_grace_period_seconds" {
  type    = number
  default = 60
}


variable "target_group_arn" {
  description = "ecs load balancer config targget group arn"
  type = string
  default = null
}

#Autoscale Variables

variable "cpu_statistic" {
  description = "Statistics to use: [Maximum, SampleCount, Sum, Minimum, Average]. Note that resolution used in alarm generated is 1 minute."
  default     = "Average"
  type        = string
}

variable "cpu_threshold" {
  description = "The CPU alarm threshold"
  default     = 85
  type        = number
}


variable "ecs_cluster_name" {
  description = "Name (not ARN) of ECS Cluster that the autoscaling group is attached to"
  type        = string
  default     = "change_me"
}

variable "ecs_max_capacity" {
  description = "The maximum capacity of the auto scaling group"
  type        = number
  default     = 4
}

variable "ecs_min_capacity" {
  description = "The minimum capacity of the auto scaling group"
  type        = number
  default     = 1
}

variable "enable_autoscaling" {
  description = "set to true to use auto scaling"
  type        = bool
  default     = false
}

variable "disable_scale_in" {
  description = "Indicates whether scale in by the target tracking policy is disabled."
  default     = false
  type        = bool
}

variable "create_discovery_record" {
  description = "Set to true to create a serice discovery record"
  default     = false
  type        = bool
}


#Dynamic Variables

/*
variable "load_balancer" {
  type = object({
    target_group_arn = string
    container_name   = string
    container_port   = string
    
  })
  default = null
  description = "For load balanced services, specify a load balancer configuratio "
}

*/

variable "load_balancers" {
  type = list(object({
    container_name   = string
    container_port   = number
    target_group_arn = string
  }))
  description = "A list of load balancer config objects for the ECS service"
  default     = []
}

variable "service_registries" {
  type = list(object({
    registry_arn   = string
    container_name = string
    container_port = number
  }))
  description = "The service discovery registries for the service. The maximum number of service_registries blocks is 1."
  default     = []
}


#Tag Variables

variable "tag_app_name" {
  description = "Application Name (eg Network Watcher)"
  type        = string
  default     = "testng"
}

variable "tag_app_owner" {
  description = "Application Owner (eg Joe Shmo)"
  type        = string
  default     = "testng"
}

variable "tag_cost_center_number" {
  description = "Cost Center number (eg 8565060)"
  type        = string
  default     = "testng"
}

variable "tag_subcost_center" {
  description = "Sub Cost Center (eg EFT Team)"
  type        = string
  default     = "testng"
}

#tags
variable "tag_name" {
  description = "Application Name"
  type        = string
  default     = "name testng"
}

variable "tag_environment" {
  description = "environment"
  type        = string
  default     = "environment testng"
}

variable "tag_contact" {
  description = "contact"
  type        = string
  default     = "contact testng"
}

variable "tag_systemtier" {
  description = "system tier"
  type        = string
  default     = "system tier testng"
}

variable "tag_drtier" {
  description = "DR tier"
  type        = string
  default     = "DR tier testng"
}

variable "tag_dataclassification" {
  description = "data classification"
  type        = string
  default     = "data classification testng"
}

variable "tag_budgetcode" {
  description = "budget code"
  type        = string
  default     = "budget code testng"
}

variable "tag_owner" {
  description = "owner"
  type        = string
  default     = "owner testng"
}

variable "tag_projectname" {
  description = "project name"
  type        = string
  default     = "project name testng"
}

variable "tag_notes" {
  description = "notes"
  type        = string
  default     = "notes testng"
}

variable "tag_eol" {
  description = "EOL"
  type        = string
  default     = "EOL tag testng"
}

variable "tag_maintwindow" {
  description = "maintenance window"
  type        = string
  default     = "maint window tag testng"
}

variable "tags" {
  type        = map(string)
  description = "Tags assigned to all capable resources."
  default     = {}
}

variable "lb_arn" {
  type = string
  default = null
}

variable "sd_record_name" {
  type = string
  description = "The service discovery DNS name of the servivce"
  default = null
}

