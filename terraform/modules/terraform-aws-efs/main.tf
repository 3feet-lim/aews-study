####################################################################
# Module Name : EFS
# Module Desc : EFS 생성
####################################################################

####################################################################
# EFS 생성
resource "aws_efs_file_system" "this" {

  encrypted                       = var.encrypted
  kms_key_id                      = var.encrypted == "true" ? var.kms_key_id : null
  availability_zone_name          = try(var.availability_zone_name, null)
  throughput_mode                 = var.throughput_mode
  performance_mode                = var.performance_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps != "" ? var.provisioned_throughput_in_mibps : null

  protection {
    replication_overwrite = var.replication_overwrite
  }

  dynamic "lifecycle_policy" {
    for_each = (var.transition_to_ia != null && var.transition_to_ia != "") ? [1] : []
    content {
      transition_to_ia = try(var.transition_to_ia, null)
    }
  }

  dynamic "lifecycle_policy" {
    for_each = (var.transition_to_archive != null && var.transition_to_archive != "") ? [1] : []
    content {
      transition_to_archive = try(var.transition_to_archive, null)
    }
  }

  dynamic "lifecycle_policy" {
    for_each = (var.transition_to_primary_storage_class != null && var.transition_to_primary_storage_class != "") ? [1] : []
    content {
      transition_to_primary_storage_class = try(var.transition_to_primary_storage_class, null)
    }
  }

  tags = merge(
    { Name = var.name },
    var.tags
  )
}

resource "aws_efs_mount_target" "this" {
  for_each       = { for k, v in var.subnet_ids : k => v }
  file_system_id = aws_efs_file_system.this.id
  #ip_address      = each.value.ip_address != "auto" ? each.value.ip_address : null
  subnet_id       = each.value
  security_groups = var.security_groups
}

resource "aws_efs_backup_policy" "this" {

  file_system_id = aws_efs_file_system.this.id

  backup_policy {
    status = var.automatic_backup_status
  }
}

resource "aws_efs_access_point" "this" {
  for_each = { for k, v in var.access_point : v.name => v }

  file_system_id = aws_efs_file_system.this.id

  root_directory {
    creation_info {
      owner_uid   = each.value.owner_uid
      owner_gid   = each.value.owner_gid
      permissions = each.value.permissions
    }
    path = each.value.path
  }
}
