# default Launch Template 생성
locals {
  default_user_data_path = "${path.module}/eks_default_userdata.sh"

  lt_eks_vars = {
    eks_cluster_name                  = try(lookup(var.lt_eks_vars, "eks_cluster_name", "null"), "null")
    eks_cluster_endpoint              = try(lookup(var.lt_eks_vars, "eks_cluster_endpoint", "null"), "null")
    eks_cluster_certificate_authority = try(lookup(var.lt_eks_vars, "eks_cluster_certificate_authority", "null"), "null")
    eks_cluster_service_ipv4_cidr     = try(lookup(var.lt_eks_vars, "eks_cluster_service_ipv4_cidr", "null"), "null")
  }

  final_user_data = length(keys(var.lt_eks_vars)) == 0 ? base64encode(var.user_data) : base64encode(templatefile(local.default_user_data_path, local.lt_eks_vars))
  tag_specifications = concat(
    length(keys(var.instance_tags)) > 0 ? [
      { resource_type = "instance", tags = var.instance_tags }
    ] : [],
    length(keys(var.volume_tags)) > 0 ? [
      { resource_type = "volume", tags = var.volume_tags }
    ] : [],
    length(keys(var.eni_tags)) > 0 ? [
      { resource_type = "network-interface", tags = var.eni_tags }
    ] : []
  )
}

resource "aws_launch_template" "this" {
  name                   = var.name
  description            = var.description
  image_id               = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  update_default_version = var.update_default_version # true
  user_data              = local.final_user_data

  tags = merge(
    { Name = var.name },
    var.tags
  )

  # root volume
  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name = block_device_mappings.value.device_name
      ebs {
        delete_on_termination = block_device_mappings.value.delete_on_termination
        volume_size           = block_device_mappings.value.volume_size
        volume_type           = block_device_mappings.value.volume_type
        iops                  = block_device_mappings.value.iops
        encrypted             = block_device_mappings.value.encrypted
        snapshot_id           = block_device_mappings.value.snapshot_id
        kms_key_id            = block_device_mappings.value.kms_key_id
      }
    }
  }

  dynamic "tag_specifications" {
    for_each = local.tag_specifications
    content {
      resource_type = tag_specifications.value.resource_type
      tags          = tag_specifications.value.tags
    }
  }

  metadata_options {
    http_put_response_hop_limit = var.http_put_response_hop_limit
    http_tokens                 = var.http_tokens
    http_endpoint               = var.http_endpoint
    instance_metadata_tags      = var.instance_metadata_tags
  }

  dynamic "network_interfaces" {
    for_each = var.network_interfaces != null ? [var.network_interfaces] : []
    content {
      device_index       = lookup(network_interfaces.value, "device_index", null)
      ipv4_address_count = lookup(network_interfaces.value, "ipv4_address_count", null)
      ipv4_addresses     = lookup(network_interfaces.value, "ipv4_addresses", null)
      ipv4_prefix_count  = lookup(network_interfaces.value, "ipv4_prefix_count", null)
      ipv4_prefixes      = lookup(network_interfaces.value, "ipv4_prefixes", null)
      ipv6_address_count = lookup(network_interfaces.value, "ipv6_address_count", null)
      ipv6_addresses     = lookup(network_interfaces.value, "ipv6_addresses", null)
      ipv6_prefix_count  = lookup(network_interfaces.value, "ipv6_prefix_count", null)
      ipv6_prefixes      = lookup(network_interfaces.value, "ipv6_prefixes", null)
      network_card_index = lookup(network_interfaces.value, "network_card_index", null)
      security_groups    = lookup(network_interfaces.value, "security_groups", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      metadata_options
    ]
  }
}
