variable "name" {
  description = "ALB 이름"
  type        = string
}

variable "internal" {
  description = "`internal` or `internet-facing`"
  type        = bool
  default     = false
}

variable "security_groups" {
  description = "ALB에 연결할 Security Group ID 목록"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "LB가 배치될 Subnet ID 목록"
  type        = list(string)
}

variable "enable_cross_zone_load_balancing" {
  description = "Cross-Zone Load Balancing 기능 활성화 여부"
  type        = bool
  default     = true
}

variable "access_log_enabled" {
  description = "ALB Access log 활성화 여부"
  type        = bool
  default     = true
}

variable "access_log_prefix" {
  description = "ALB Access log bucket prefix"
  type        = string
  default     = ""
}

variable "access_log_bucket_name" {
  description = "ALB Access log 버킷 이름"
  type        = string
  default     = null
}

variable "enable_deletion_protection" {
  description = "ALB 삭제 방지 기능 활성화 여부"
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "ALB에서 http/2 프로토콜 지원 활성화 여부"
  type        = bool
  default     = true
}

variable "ip_address_type" {
  description = "ALB가 사용할 IP 주소 유형 (ipv4 or dualstack)."
  type        = string
  default     = "ipv4"
}

variable "idle_timeout" {
  description = "ALB 연결이 유휴 상태로 유지될 때 최대 시간(초)"
  type        = number
  default     = 60
}

variable "drop_invalid_header_fields" {
  description = "ALB가 잘못된 형식의 HTTP 헤더를 감지했을 때 자동 제거 여부"
  type        = bool
  default     = false
}

variable "listeners" {
  description = "ALB에 생성할 리스터의 설정 목록"
  type = list(object({
    port                  = number
    protocol              = string
    ssl_policy            = optional(string)
    certificate_arn       = optional(string)
    secondary_certificate = optional(string)
    order                 = optional(string)
    forward = optional(object({
      target_group_arn = optional(string)
    }))
    redirect = optional(object({
      host        = optional(string)
      path        = optional(string)
      port        = optional(string)
      protocol    = optional(string)
      query       = optional(string)
      status_code = string
    }))
  }))
}

variable "tags" {
  description = "ALB에 부여할 태그"
  type        = map(string)
  default     = {}
}
