####################################################################
# Module Name : EC2 Instance
# Module Desc : EC2 Instance를 생성합니다.
####################################################################

####################################################################
# EC2 Instance 생성
resource "aws_instance" "this" {
  ami                     = var.ami
  instance_type           = var.instance_type
  key_name                = try(var.key_name, null)
  vpc_security_group_ids  = var.vpc_security_group_ids
  subnet_id               = var.subnet_id
  user_data               = try(var.user_data, null)
  disable_api_termination = var.disable_api_termination
  iam_instance_profile    = try(var.iam_instance_profile, null)
  ipv6_address_count      = try(var.ipv6_address_count, null)
  private_ip              = try(var.private_ip, null)
  source_dest_check       = try(var.source_dest_check, null)

  dynamic "launch_template" {
    for_each = var.launch_template != null ? [var.launch_template] : []
    iterator = lt
    content {
      id = lt.value.id
      version = lt.value.version
    }
  }

  metadata_options {
    http_tokens                 = var.http_tokens
    http_endpoint               = var.http_endpoint
    http_put_response_hop_limit = var.http_put_response_hop_limit
    instance_metadata_tags      = var.instance_metadata_tags
  }

  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    encrypted             = var.encrypted
    delete_on_termination = var.delete_on_termination
    tags = merge(
      { Name = var.name },
      { Backup = "ebs" },
      var.volume_tags
    )

  }
  tags = merge(
    { Name = var.name },
    { Backup = "ec2" },
    var.tags
  )

  lifecycle {
    ignore_changes = [
      tags["InstanceScheduler-LastAction"]
    ]
  }
}