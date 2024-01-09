#File System

resource "aws_efs_file_system" "fs" {
  encrypted        = var.encrypted
  performance_mode = var.performance_mode

   dynamic "lifecycle_policy" {
    for_each = var.transition_to_ia == "" ? [] : [1]
    content {
      transition_to_ia = var.transition_to_ia
    }
  }

  tags = local.tags
}


#Access Point

#Policy 

resource "aws_efs_access_point" "access_point" {
  file_system_id = aws_efs_file_system.fs.id
  
posix_user {
    gid = var.posix_user_gid
    uid = var.posix_user_uid
  }
  

   root_directory {
    path = var.access_point_path
    creation_info {
      owner_gid   = var.posix_user_gid
      owner_uid   = var.posix_user_uid
      permissions = var.path_permissions
    }
}
  tags = local.tags
}

resource "aws_efs_file_system_policy" "fs_policy" {
  file_system_id = aws_efs_file_system.fs.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "EFSReadPolicy01",
    "Statement": [
        {
            "Sid": "${var.app_name}-${var.environment}-EFSReadPolidy102020",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Resource": "${aws_efs_file_system.fs.arn}",
            "Action": [
                "elasticfilesystem:ClientRootAccess",
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "true"
                }
            }
        }
    ]
}
POLICY
}



#Network interfaces

resource "aws_efs_mount_target" "mount_target" {
  count = length(var.subnet_ids)

  file_system_id  = aws_efs_file_system.fs.id
  subnet_id       = element(var.subnet_ids, count.index)
  security_groups = var.security_groups
}
