####################################################################
# Module Name : EventBridge Rule
# Module Desc : EventBridge Rule 생성
####################################################################
####################################################################
# EventBridge Rule생성
resource "aws_cloudwatch_event_rule" "this" {
  name                = var.name
  description         = var.description
  schedule_expression = var.schedule_expression
  event_pattern       = var.event_pattern
  state               = var.state
  role_arn            = var.role_arn
}

resource "aws_cloudwatch_event_target" "this" {
  for_each = var.targets

  rule       = aws_cloudwatch_event_rule.this.name
  arn        = each.value.arn
  input      = lookup(each.value, "input", null)
  input_path = lookup(each.value, "input_path", null)
  role_arn   = lookup(each.value, "role_arn", null)

  dynamic "dead_letter_config" {
    for_each = lookup(each.value, "dead_letter_arn", null) != null ? [each.value.dead_letter_arn] : []
    content {
      arn = dead_letter_config.value
    }
  }
}
