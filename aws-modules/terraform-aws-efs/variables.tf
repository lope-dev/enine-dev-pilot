variable "app_name" {
  type        = string
  description = "The applcation name (used in naming)"
  default     = "app-name"
}

variable "app_environment" {
  type        = string
  description = "The applcation environment name (used in naming)"
  default     = "dev"
}


variable "region" {
  description = "the AWS region in which to deploy VPC and its resources"
  default     = "us-east-1"
}
variable "environment" {
  description = "deployment environment"
  default     = "dev"
}
variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}
variable "vpc" {
  default = "vpc-0c7d4d78da079d69a"
}

variable "subnet_ids" {
  type = list(string)
  description = "The subnet to place the mount target interface in"
  default = []
}

variable "security_groups" {
  description = "The security groups to apply to the mount target interface"
  type = list(string)
  default = []
}


variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.96.64.0/20"
}

#variable "subnet_ids" {
#  type        = list
#  description = "(Required) A list of subnet ids where mount targets will be."
#}

#tags
variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "encrypted" {
  description = "encryption of efs storage"
  type       = string
  default    = true
}

variable "performance_mode" {
  description = "Performance mode for the efs"
  type        = string
  default     = "generalPurpose"
}

variable "remote_state_bucket" {
  description = "remote state bucket name"
  default     = "testbucket"
}

variable "pub_name" {
  description = "name of the project"
  default = "efs"
}

/*locals {
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  private_subnets = slice(data.terraform_remote_state.network.outputs.private_subnets, 0, min(length(data.terraform_remote_state.network.outputs.azs), length(data.terraform_remote_state.network.outputs.private_subnets)))
  public_subnets = slice(data.terraform_remote_state.network.outputs.public_subnets, 0, min(length(data.terraform_remote_state.network.outputs.azs), length(data.terraform_remote_state.network.outputs.public_subnets)))
  tags = {
    Environment = var.environment
    Terraform = "True"
    Owner = "Infra"
    Project = var.pub_name
  }
}
*/

variable "transition_to_ia" {
  type        = string
  description = "Indicates how long it takes to transition files to the IA storage class. Valid values: AFTER_7_DAYS, AFTER_14_DAYS, AFTER_30_DAYS, AFTER_60_DAYS and AFTER_90_DAYS"
  default     = ""
}

variable "posix_user_gid" {
  type        = number
  description = "The gid of the Posix user"
  default     = 999
}

variable "posix_user_uid" {
  type        = number
  description = "The gid of the Posix user"
  default     = 999
}

variable "path_permissions" {
  type = number
  description = "The permissions t assign to the path in the access point"
  default = 644
}

variable "access_point_path" {
  type = string
  description = "The path where the access point will be accessed. "
  default = "/config"
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
