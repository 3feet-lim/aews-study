####################################################################
# Module Name : nlb
# Module Desc : nlb를 생성합니다.
####################################################################

####################################################################
# nlb를 생성
resource "aws_lb" "this" {
  load_balancer_type               = "network"
  name                             = var.name
  internal                         = var.internal
  ip_address_type                  = var.ip_address_type
  subnets                          = var.subnet_mappings == null ? var.subnets : null
  security_groups                  = var.security_groups
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection
  dns_record_client_routing_policy = var.dns_record_client_routing_policy

  dynamic "subnet_mapping" {
    for_each = var.subnet_mappings != null ? var.subnet_mappings : {}
    content {
      subnet_id = subnet_mapping.key
      private_ipv4_address = subnet_mapping.value
    }
  }

  dynamic "access_logs" {
    for_each = var.access_log_enabled ? [1] : []
    content {
      bucket = var.access_log_bucket_name != null ? var.access_log_bucket_name : aws_s3_bucket.this[0].id
      prefix  = var.access_log_prefix
      enabled = var.access_log_enabled
    }
  }

  tags = merge(
    { Name = var.name },
    var.tags
  )
}

# Access Log 저장용 버킷 생성
resource "aws_s3_bucket" "this" {
  count  = var.access_log_enabled && var.access_log_bucket_name == null ? 1 : 0
  bucket = var.access_log_bucket_name != null ? var.access_log_bucket_name : "${var.name}-access-log"
}

# Access log 저장소 s3정책 설정
resource "aws_s3_bucket_policy" "this" {
  count  = var.access_log_enabled && var.access_log_bucket_name == null ? 1 : 0
  bucket = aws_s3_bucket.this[count.index].id
  policy = data.aws_iam_policy_document.s3_policy[count.index].json
}

data "aws_iam_policy_document" "s3_policy" {
  count = var.access_log_enabled && var.access_log_bucket_name == null ? 1 : 0

  statement {
    sid    = "AWSLoadBalancerLoggingPermissions"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this[count.index].id}/*"
    ]
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count = var.access_log_enabled && var.access_log_bucket_name == null ? 1 : 0
  bucket = aws_s3_bucket.this[count.index].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

####################################################################
# nlb의 Listener생성 및 Target Group을 연결 합니다.
####################################################################
resource "aws_lb_listener" "this" {
  for_each = {
    for listener in var.listeners :
    "${listener.protocol}-${listener.port}" => listener
  }

  load_balancer_arn = aws_lb.this.arn
  port              = each.value.port
  protocol          = each.value.protocol
  certificate_arn   = try(each.value.certificate_arn, null)
  ssl_policy        = try(each.value.ssl_policy, null)

  default_action {
    target_group_arn = try(each.value.target_group_arn, null)
    type             = "forward"
  }
}


####################################################################
# 추가 SSL Certification을 지정합니다.
####################################################################

resource "aws_lb_listener_certificate" "this" {
  for_each = { for cert in var.secondary_certificate : "${cert.name}" => cert }

  listener_arn    = aws_lb_listener.this["${each.value.port}-${each.value.protocol}"].arn
  certificate_arn = each.value.cert
}
