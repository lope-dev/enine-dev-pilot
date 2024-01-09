// Global Variables

variable "app_name" {
  type    = string
  default = "develop"
}


variable "environment" {
  type    = string
  default = "develop"
}

variable "name" {
  type    = string
  default = "alb_stack"
}

variable "project" {
  type    = string
  default = "pe"
}

// Data Source Variables

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}


// AWS Security Group Variables

variable "description" {
  type = string
  default = ""
}


// AWS Application Load Balancer Variables

variable "internal" {
  type    = bool
  default = false
}

variable "load_balancer_type" {
  type    = string
  default = "application"
}

variable "enable_deletion_protection" {
  type    = string
  default = true
}

variable "prefix" {
  type    = string
  default = "alb-"
}

variable "enabled" {
  type    = bool
  default = true
}

variable "certificate_arn" {
  type = string
  default = ""
}

// AWS Application Load Balancer Target Group Variables

variable "target_type" {
  type    = string
  default = "lambda"
}

variable "target_group_port" {
  type    = string
  default = "9443"
}

variable "target_group_protocol" {
  type    = string
  default = "HTTPS"
}

variable "health_check_path" {
  type    = string
  default = null
}

variable "health_check_protocol" {
  type    = string
  default = null
}

variable "health_check_interval" {
  type    = string
  default = null
}




// AWS Application Load Balancer Listener Variables

variable "listener_port" {
  type    = string
  default = "443"
}

variable "listener_protocol" {
  type    = string
  default = "HTTPS"
}

variable "ssl_policy" {
  type    = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "action" {
  type    = string
  default = "forward"
}

// AWS ACM Certificate Variables

variable "domain_name" {
  type    = string
  default = "thinkahead.dev"
}

variable "validation_method" {
  type    = string
  default = "DNS"
}

variable "health_check_timeout" {
  type    = string
  default = null
}

variable "health_check_healthy_threshold" {
  type    = string
  default = null
}

variable "health_check_unhealthy_threshold" {
  type    = string
  default = null
}

variable "health_check_matcher" {
  type    = string
  default = null
}

variable "health_check_port" {
  type    = string
  default = null
}

/*
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
*/

variable "tags" {
  type        = map(string)
  description = "Tags assigned to all capable resources."
  default     = {}
}

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


