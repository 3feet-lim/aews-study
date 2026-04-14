# Redis SSO subnet Group 생성
resource "aws_elasticache_subnet_group" "this" {
  name        = var.subnet_group_name
  description = var.subnet_group_description
  subnet_ids  = var.subnet_ids
  tags = merge(
    { Name = var.subnet_group_name },
    var.subnet_group_tags
  )
}

# Redis SSO Parameter Group 생성
resource "aws_elasticache_parameter_group" "this" {

  name        = var.parameter_group_name
  description = var.parameter_group_description
  family      = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameter_group_list
    content {
      name  = parameter.key
      value = parameter.value
    }
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_elasticache_cluster" "this" {
  # 엔진 및 생성 유형
  cluster_id     = var.cluster_id
  engine         = "redis"
  engine_version = var.engine_version
  node_type      = var.node_type
  port           = var.port

  num_cache_nodes = 1

  # 네트워크
  subnet_group_name    = aws_elasticache_subnet_group.this.name
  security_group_ids   = var.security_group_ids
  parameter_group_name = aws_elasticache_parameter_group.this.name

  # 보안
  transit_encryption_enabled = var.transit_encryption_enabled

  # 유지관리 및 백업
  apply_immediately          = try(var.apply_immediately, null)
  snapshot_retention_limit   = try(var.snapshot_retention_limit, null)
  maintenance_window         = var.maintenance_window
  snapshot_window            = var.snapshot_window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  dynamic "log_delivery_configuration" {
    for_each = var.log_delivery_configuration
    content {
      destination      = log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = log_delivery_configuration.value.log_type
    }
  }

  lifecycle {
    ignore_changes = [maintenance_window]
  }

  tags = merge(
    { Name = var.cluster_id },
    var.cluster_tags
  )
}
