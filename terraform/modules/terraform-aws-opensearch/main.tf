####################################################################
# Module Name : Opensearch
# Module Desc : VPC 내부에 Opensearch 도메인을 생성합니다.
####################################################################

###############################################
# Opensearch 생성
###############################################
resource "aws_opensearch_domain" "this" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  # 클러스터 구성 
  cluster_config {
    instance_type  = var.instance_type
    instance_count = var.instance_count

    # AZ 분산
    zone_awareness_enabled = var.zone_awareness_enabled
    dynamic "zone_awareness_config" {
      for_each = var.zone_awareness_enabled ? [1] : []
      content {
        availability_zone_count = var.az_count
      }
    }
  }

  # EBS 설정
  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_type = var.volume_type
    volume_size = var.volume_size
    iops        = try(var.iops, null)
    throughput  = try(var.throughput, null)
  }

  # VPC 배치
  dynamic "vpc_options" {
    for_each = var.subnet_id != null ? [1] : []
    content {
      subnet_ids         = [var.subnet_id]
      security_group_ids = var.security_group_ids
    }
  }

  domain_endpoint_options {
    enforce_https       = var.enforce_https
    tls_security_policy = var.tls_security_policy
  }

  node_to_node_encryption {
    enabled = var.node_to_node_encryption
  }

  encrypt_at_rest {
    enabled = var.encrypt_at_rest
  }

  # 고급 보안(FGAC)
  dynamic "advanced_security_options" {
    for_each = var.fgac_enabled && var.master_user_name != null && var.master_user_password != null ? [1] : []
    content {
      enabled                        = true
      internal_user_database_enabled = true
      anonymous_auth_enabled         = try(var.anonymous_auth_enabled, false)

      master_user_options {
        master_user_name     = var.master_user_name
        master_user_password = var.master_user_password
        master_user_arn      = var.master_user_arn
      }
    }
  }

  access_policies = var.access_policies

  depends_on = [aws_iam_service_linked_role.opensearch]
}

# 최초 ES생성시 관리형 권한 생성
resource "aws_iam_service_linked_role" "opensearch" {
  aws_service_name = "es.amazonaws.com"
}
