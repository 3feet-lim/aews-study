resource "aws_lb_target_group" "this" {
  name        = var.name
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    enabled             = var.health_check_enabled
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = var.health_check_protocol
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
    matcher             = var.health_check_matcher
  }
  deregistration_delay = var.deregistration_delay

  stickiness {
    enabled = var.stickiness_enabled
    type    = "source_ip"
  }

  proxy_protocol_v2 = var.proxy_protocol_v2

  tags = merge(
    { Name = var.name },
    var.tags
  )
}

# 여러 Target 등록
resource "aws_lb_target_group_attachment" "this" {
  for_each = {
    for t in var.targets : t.id => t
  }

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = each.value.id
  port             = try(each.value.port, var.port)
}
