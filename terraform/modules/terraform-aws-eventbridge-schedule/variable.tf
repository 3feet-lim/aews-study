variable "name" {
  description = "EventBridge Scheduler 이름"
  type        = string
}

variable "description" {
  description = "EventBridge Scheduler 설명"
  type        = string
  default     = null
}

variable "group_name" {
  description = "EventBridge Scheduler 그룹 지정"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "EventBridge Scheduler 이름의 접두사"
  type        = string
  default     = null
}

variable "action_after_completion" {           
  description = "EventBridge Scheduler의 실행후 스케줄 동작"
  type        = string
  default     = "NONE"
}

variable "start_date" {
  description = "EventBridge Scheduler 시작시점"
  type        = string
  default     = null
}

variable "end_date" {
  description = "EventBridge Scheduler 종료시점"
  type        = string
  default     = null
}


variable "kms_key_arn" {
  description = "EventBridge Scheduler 암호화키 지정"
  type        = string
  default     = null
}

variable "schedule_expression" {
  description = "EventBridge Scheduler 스케줄링(Cron)"
  type        = string
}

variable "schedule_expression_timezone" {
  description = "EventBridge Scheduler 스케줄링 타임존"
  type        = string
  default     = "Asia/Seoul"
}


variable "state" {
  description = "EventBridge Scheduler 활성화 여부"
  type        = string
  default     = "ENABLED"
}

variable "flexible_maximum_window_in_minutes" {
  description = "EventBridge Scheduler 의 지정 시간내 유연하게 동작"
  type        = number
  default     = null
}

variable "flexible_mode" {
  description = "EventBridge Scheduler 유연화 동작 여부"
  type        = string
  default     = "OFF"
}

variable "targets" {
  description = "EEventBridge Scheduler 대상 목록 및 설정"
  type = map(object({
    arn             = string
    role_arn        = optional(string)
    input           = optional(string)
    dead_letter_arn = optional(string)
    maximum_retry_attempts    = optional(number)
    maximum_event_age_in_seconds    = optional(number)
  }))
  default = {}
}
