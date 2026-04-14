resource "aws_lb" "this" {
  name                             = var.name
  internal                         = var.internal
  load_balancer_type               = "application"
  security_groups                  = var.security_groups
  subnets                          = var.subnets
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection
  enable_http2                     = var.enable_http2
  ip_address_type                  = var.ip_address_type

  idle_timeout               = var.idle_timeout
  drop_invalid_header_fields = var.drop_invalid_header_fields

  dynamic "access_logs" {
    for_each = var.access_log_enabled ? [1] : []
    content {
      bucket = var.access_log_bucket_name != null ? var.access_log_bucket_name : aws_s3_bucket.this[0].id
      #bucket  = var.access_log_bucket_name
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
  count  = var.access_log_enabled && var.access_log_bucket_name == null ? 1 : 0
  bucket = aws_s3_bucket.this[count.index].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# Listener
resource "aws_lb_listener" "this" {
  for_each = {
    for l in var.listeners : "${l.protocol}-${l.port}" => l
  }

  load_balancer_arn = aws_lb.this.arn
  port              = each.value.port
  protocol          = each.value.protocol
  certificate_arn   = each.value.protocol == "HTTPS" ? each.value.certificate_arn : null
  ssl_policy        = each.value.protocol == "HTTPS" ? try(each.value.ssl_policy, "ELBSecurityPolicy-2016-08") : null

  dynamic "default_action" {
    for_each = each.value.forward != null ? [each.value.forward] : []

    content {
      order            = each.value.order
      target_group_arn = each.value.target_group_arn
      type             = "forward"
    }
  }

  dynamic "default_action" {
    for_each = each.value.redirect != null ? [each.value.redirect] : []

    content {
      redirect {
        host        = default_action.value.host
        path        = default_action.value.path
        port        = default_action.value.port
        protocol    = default_action.value.protocol
        query       = default_action.value.query
        status_code = default_action.value.status_code
      }
      order = each.value.order
      type  = "redirect"
    }
  }
}

resource "aws_lb_listener_certificate" "this" {
  for_each = { for l in var.listeners : "${l.protocol}-${l.port}" => l
    if l.secondary_certificate != null && l.secondary_certificate != ""
  }

  listener_arn    = aws_lb_listener.this["${each.value.protocol}-${each.value.port}"].arn
  certificate_arn = each.value.secondary_certificate
}
