variable "name" {
  description = "Target group name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "port" {
  description = "Port for target group and targets"
  type        = number
}

variable "protocol" {
  description = "target group Protocol"
}

variable "targets" {
  description = "List of targets to register"
  type = list(object({
    id   = string
    port = optional(number)
  }))
  default = []
}

variable "health_check_enabled" {
  description = "Health check 활성화 여부"
  type        = bool
  default     = true
}

variable "health_check_interval" {
  description = "Health check 수행 간격"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "Health check 요청 경로"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Health check를 수행할 port"
  type        = string
  default     = "traffic-port"
}

variable "health_check_protocol" {
  description = "Health check 시 사용하는 프로토콜"
  type        = string
  default     = "HTTP"
}

variable "health_check_healthy_threshold" {
  description = "Health check 성공으로 간주하기 위한 연속 성공 횟수"
  type        = number
  default     = 3
}

variable "health_check_unhealthy_threshold" {
  description = "Health check 실패로 간주하기 위한 연속 실패 횟수"
  type        = number
  default     = 3
}

variable "health_check_timeout" {
  description = "Health check 요청 후 응답을 기다리는 최대 시간(초)"
  type        = number
  default     = 5
}

variable "health_check_matcher" {
  description = "Health check 성공으로 간주할 응답 코드"
  type        = string
  default     = "200"
}

# Target Group Attributes
variable "deregistration_delay" {
  description = "Target group에서 대상이 등록 해제된 후 연결을 완전히 종료하기 전까지 대기하는 시간(초)"
  type        = number
  default     = 300
}

variable "stickiness_enabled" {
  description = "고정 세션 기능 활성화 여부"
  type        = bool
  default     = false
}

variable "cookie_duration" {
  description = "Duration of stickiness cookie in seconds"
  type        = number
  default     = 86400
}

variable "tags" {
  description = "Targe Group 태그"
  type        = map(string)
  default     = {}
}