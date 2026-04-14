####################################################################
# Module Name : EventBridge Scheduler
# Module Desc : EventBridge Scheduler 생성
####################################################################
####################################################################
# EventBridge Scheduler생성
resource "aws_scheduler_schedule" "this" {
  name                = var.name
  description         = var.description
  name_prefix         = var.name_prefix

  schedule_expression_timezone = var.schedule_expression_timezone
  schedule_expression = var.schedule_expression

  action_after_completion = var.action_after_completion
  end_date = var.end_date
  start_date = var.start_date
  group_name = var.group_name
  kms_key_arn = var.kms_key_arn
  state               = var.state

  flexible_time_window {
    maximum_window_in_minutes = var.flexible_maximum_window_in_minutes
    mode = var.flexible_mode
  }

  dynamic "target" {
    for_each = var.targets
    content{
      arn           = lookup(target.value, "arn", null)
      role_arn      = lookup(target.value, "role_arn", null)
      input         = lookup(target.value, "input", null)
      
      dynamic "dead_letter_config" {
        for_each = lookup(target.value, "dead_letter_arn", null) != null ? [target.value.dead_letter_arn] : []
        content {
          arn = dead_letter_config.value
        }
      }
    
      dynamic "retry_policy" {
        for_each = lookup(target.value, "maximum_retry_attempts", null) != null ? [target.value.dead_letter_arn] : []
        content {
          maximum_retry_attempts = lookup(target.value, "maximum_retry_attempts", null)
          maximum_event_age_in_seconds = lookup(target.value, "maximum_event_age_in_seconds", null)
        }
      }
    }
  }

}
