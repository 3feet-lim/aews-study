####################################################################
# Module Name : EC2 EBS Volume
# Module Desc : EC2 EBS Volume을 생성합니다.
####################################################################

####################################################################
# EC2 EBS Volume을 생성합니다.
####################################################################
###############################################
# EC2 EBS Volume
###############################################
resource "aws_ebs_volume" "this" {
  for_each = { for ebs in var.volume_info : "${ebs.name}" => ebs }

  encrypted         = true
  type              = each.value.type
  iops              = contains(["io1", "io2", "gp3"], each.value.type) && each.value.iops != "" ? each.value.iops : null
  throughput        = contains(["gp3"], each.value.type) && each.value.throughput != "" ? each.value.throughput : null
  size              = each.value.size
  availability_zone = each.value.availability_zone

  tags = merge(
    { Name = each.value.name },
    each.value.tags
  )
}

###############################################
# EC2 EBS Volume Attachment
###############################################
resource "aws_volume_attachment" "this" {
  for_each = { for ebs in var.volume_info : "${ebs.name}" => ebs }

  device_name = each.value.device_name
  volume_id   = aws_ebs_volume.this[each.value.name].id
  instance_id = var.instance_id
}