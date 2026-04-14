variable "name" {
  description = "EventBridge rule name"
  type        = string
}

variable "description" {
  description = "EventBridge rule description"
  type        = string
  default     = null
}

variable "schedule_expression" {
  description = "EventBridge rule schedule expression"
  type        = string
  default     = null
}

variable "event_pattern" {
  description = "EventBridge rule event pattern"
  type        = string
  default     = null
}

variable "state" {
  description = "EventBridge rule state"
  type        = string
  default     = "ENABLED"
}

variable "role_arn" {
  description = "EventBridge rule arn for assume"
  type        = string
  default     = null
}

variable "targets" {
  description = "EventBridge rule target list"
  type = map(object({
    arn             = string
    input           = optional(string)
    input_path      = optional(string)
    role_arn        = optional(string)
    dead_letter_arn = optional(string)
  }))
  default = {}
}
