#------------------------------------------------------------------------------
# AWS ECS Task Definition Variables
#------------------------------------------------------------------------------
variable "task_name" {
  type = string
}

variable "command" {
  description = "(Optional) The command that is passed to the container"
  type        = list(string)
  default     = null
}

variable "container_cpu" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
  description = "(Optional) The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
  default     = 2048 # 1 vCPU
}

variable "container_depends_on" {
  description = "(Optional) The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed"
  type = list(object({
    containerName = string
    condition     = string
  }))
  default = null
}

variable "container_memory" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
  description = "(Optional) The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
  default     = 4096 # 4 GB
}

variable "container_memory_reservation" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
  description = "(Optional) The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
  default     = 2048 # 2 GB
}

variable "network_mode" {
  type = string
  description = "The networking mode of the container task - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html"
  default = "awsvpc"
}

variable "dns_servers" {
  type        = list(string)
  description = "(Optional) Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers"
  default     = null
}

variable "docker_labels" {
  description = "(Optional) The configuration options to send to the `docker_labels`"
  type        = map(string)
  default     = null
}

variable "entrypoint" {
  description = "(Optional) The entry point that is passed to the container"
  type        = list(string)
  default     = null
}

variable "environment" {
  description = "(Optional) The environment variables to pass to the container. This is a list of maps"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "essential" {
  description = "(Optional) Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value"
  type        = bool
  default     = true
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html
variable "firelens_configuration" {
  description = "(Optional) The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html"
  type = object({
    type    = string
    options = map(string)
  })
  default = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HealthCheck.html
variable "healthcheck" {
  description = "(Optional) A map containing command (string), timeout, interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy), and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries)"
  type = object({
    command     = list(string)
    retries     = number
    timeout     = number
    interval    = number
    startPeriod = number
  })
  default = null
}

variable "links" {
  description = "(Optional) List of container names this container can communicate with without port mappings"
  type        = list(string)
  default     = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html
variable "linux_parameters" {
  description = "Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html"
  type = object({
    capabilities = object({
      add  = list(string)
      drop = list(string)
    })
    devices = list(object({
      containerPath = string
      hostPath      = string
      permissions   = list(string)
    }))
    initProcessEnabled = bool
    maxSwap            = number
    sharedMemorySize   = number
    swappiness         = number
    tmpfs = list(object({
      containerPath = string
      mountOptions  = list(string)
      size          = number
    }))
  })

  default = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html
variable "log_configuration" {
  description = "(Optional) Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html"
  type = object({
    logDriver = string
    options   = map(string)
    secretOptions = list(object({
      name      = string
      valueFrom = string
    }))
  })
  default = null
}

variable "mount_points" {
  description = "(Optional) Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`"
  type = list(object({
    containerPath = string
    sourceVolume  = string
  }))
  default = []
}

variable "port_mappings" {
  description = "The port mappings to configure for the container. This is a list of maps. Each map should contain \"containerPort\", \"hostPort\", and \"protocol\", where \"protocol\" is one of \"tcp\" or \"udp\". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort"
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
  default = [
    {
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }
  ]
}

variable "task_role_arn" {
  description = "(Optional) The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services. If not specified, `aws_iam_role.ecs_task_execution_role.arn` is used"
  type        = string
  default     = null
}

variable "execution_role_arn" {
  description = "(Optional) The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services. If not specified, `aws_iam_role.ecs_task_execution_role.arn` is used"
  type        = string
  default     = null
}

variable "readonly_root_filesystem" {
  description = "(Optional) Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
  type        = bool
  default     = false
}

variable "repository_credentials" {
  description = "(Optional) Container repository credentials; required when using a private repo.  This map currently supports a single key; \"credentialsParameter\", which should be the ARN of a Secrets Manager's secret holding the credentials"
  type        = map(string)
  default     = null
}

variable "secrets" {
  description = "(Optional) The secrets to pass to the container. This is a list of maps"
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = null
}

variable "start_timeout" {
  description = "(Optional) Time duration (in seconds) to wait before giving up on resolving dependencies for a container."
  default     = 30
}

variable "system_controls" {
  description = "(Optional) A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = \"\", value = \"\"}"
  type        = list(map(string))
  default     = null
}

variable "stop_timeout" {
  description = "(Optional) Timeout in seconds between sending SIGTERM and SIGKILL to container"
  type        = number
  default     = 30
}

variable "ulimits" {
  description = "(Optional) Container ulimit settings. This is a list of maps, where each map should contain \"name\", \"hardLimit\" and \"softLimit\""
  type = list(object({
    name      = string
    hardLimit = number
    softLimit = number
  }))
  default = null
}

variable "user" {
  description = "(Optional) The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group"
  type        = string
  default     = null
}

variable "volumes_from" {
  description = "(Optional) A list of VolumesFrom maps which contain \"sourceContainer\" (name of the container that has the volumes to mount) and \"readOnly\" (whether the container can write to the volume)"
  type = list(object({
    sourceContainer = string
    readOnly        = bool
  }))
  default = null
}

variable "working_directory" {
  description = "(Optional) The working directory to run commands inside the container"
  type        = string
  default     = null
}

variable "container_definition_vars" {
  type        = map(string)
  description = "Variables to pass to the lambda iam policy template"
  default     = {}
}

#------------------------------------------------------------------------------
# AWS ECS Task Definition Variables
#------------------------------------------------------------------------------
variable "placement_constraints" {
  description = "(Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain \"type\" and \"expression\""
  type        = list
  default     = []
}

variable "proxy_configuration" {
  description = "(Optional) The proxy configuration details for the App Mesh proxy. This is a list of maps, where each map should contain \"container_name\", \"properties\" and \"type\""
  type        = list
  default     = []
}

variable "volume" {
  description = "(Optional) A set of volume blocks that containers in your task may use. This is a list of maps, where each map should contain \"name\", \"host_path\", \"docker_volume_configuration\" and \"efs_volume_configuration\". Full set of options can be found at https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html"
  default     = []
}

variable "conf_file_system_id" {
  type = string
  default = ""

}

variable "conf_access_point_id" {
  type = string
  default = ""

}

variable "environment_name" {
  type = string
  default = "not_set"
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
