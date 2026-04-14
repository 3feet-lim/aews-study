####################################################################
# Module Name : ElastiCache (Redis)
# Module Desc : Redis SSO 를 생성합니다.
####################################################################

locals {
  auth_token_update_strategy = (
    var.auth_token == null ? null : coalesce(var.auth_token_update_strategy, "ROTATE")
  )
  subnet_group_name = var.subnet_group_name == null ? "${var.name}-sbng-int-redis" : var.subnet_group_name
}

###############################################
# Redis SSO 생성
###############################################
resource "aws_elasticache_replication_group" "this" {

  # 엔진 및 생성 유형
  engine         = "redis"
  engine_version = var.engine_version
  node_type      = var.node_type
  port           = var.port

  replication_group_id = var.name
  description          = var.description


  # 클러스터 모드 설정
  cluster_mode            = var.cluster_mode
  num_node_groups         = var.num_node_groups
  replicas_per_node_group = var.replicas_per_node_group

  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled           = var.multi_az_enabled


  # 네트워크
  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = var.security_group_ids

  # 보안
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  kms_key_id                 = var.kms_key_id
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.auth_token
  auth_token_update_strategy = local.auth_token_update_strategy

  # 유지관리 및 백업
  apply_immediately          = try(var.apply_immediately, null)
  snapshot_retention_limit   = try(var.snapshot_retention_limit, null)
  maintenance_window         = var.maintenance_window
  snapshot_window            = var.snapshot_window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  # 로그
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
    { Name = var.name },
    var.cluster_tags
  )
}

###########################################################
# Redis SSO Subnet Group 생성
resource "aws_elasticache_subnet_group" "this" {
  name        = local.subnet_group_name
  description = var.subnet_group_description != null ? var.subnet_group_description : "Subnet group for ${var.name}"
  subnet_ids  = var.subnet_ids
  tags = merge(
    { Name = local.subnet_group_name },
    var.subnet_group_tags
  )
}

###########################################################
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