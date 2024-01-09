# Option 1
variable "disk_labels" {
    type        = set(string)
    description = "The label name for disks"
    default     = ["disk1", "disk2", "disk3"]
}

variable "disk_size" {
    type        = list(number)
    description = "The label name for disks"
    default     = [1, 2, 3]
}

#Then create variable number of data disks for the resource using this cmd 
# dynamic "disk" {
#   for_each = var.disk_labels

#   content {
#    label       = each.value
#    size        = var.disk_size[count.index]
#   }
# }

# Option 2
variable "disk_names" {
  type = list(object({
        disk_labels       = list(string)
        disk_sizes 		= list(number)
  }))
}

# auto.tfvars will define the disk_names and disk_size as follows
# disk_labels = ["disk1", "disk2", "disk3"]
# disk_sizes = [0, 1, 2]

# Then create variable number of data disks for the resource using this cmd 
# dynamic "disk" {
#     for_each = {for disk in var.disk_names:  disk.name => disk}
#     label = disk.value.disk_labels
#     size  = disk.value.disk_sizes


# Option 3 We define values as locals. 
locals {
  disks = [
    { "disk_label":0, "disk_size":10 },
    { "disk_label":1, "disk_size":20  },
    { "disk_label":2, "disk_size":20  } 
  ]
}
# Then create variable number of data disks for the resource using this cmd 
# dynamic "disk" {
#     for_each = [ for disk in local.disks: disk ]
#     content {
#         label       = "disk${disk.value.disk_label}"
#         size        = disk.value.disk_size
#   }
# }

