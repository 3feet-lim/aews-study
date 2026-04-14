variable "name" {
  description = "Target group 이름"
  type        = string
}

variable "vpc_id" {
  description = "Target group이 속한 VPC ID"
  type        = string
}

variable "protocol" {
  description = "통신 protocol (TCP, TLS, UDP, TCP_UDP)"
  type        = string
  default     = "TCP"
}

variable "port" {
  description = "Target group이 수신할 port"
  type        = number
}

variable "target_type" {
  description = "Target type: `instance` or `ip` or `alb`"
  type        = string
  default     = "instance"
  validation {
    condition     = contains(["instance", "ip", "alb"], var.target_type)
    error_message = "Target Type은 instance, ip, alb 중에 하나여야 합니다."
  }
}

variable "targets" {
  description = "Target group에 등록할 대상 리스트"
  type = list(object({
    id   = string
    port = optional(number)
  }))

  validation {
    condition = (
      var.target_type != "alb" || length(var.targets) <= 1
    )
    error_message = "Target type이 `alb` 일 때는 하나의 target만 지정할 수 있습니다."
  }
}

# Health check
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
  default     = null
}

variable "health_check_protocol" {
  description = "Health check 시 사용하는 프로토콜"
  type        = string
  default     = "TCP"
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
  default     = null
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

variable "proxy_protocol_v2" {
  description = "NLB(TCP/TLS)용 Proxy protocol v2 활성화 여부"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Targe Group 태그"
  type        = map(string)
  default     = {}
}
