variable "name" {
  description = "NLB 이름"
  type        = string
}

variable "internal" {
  description = "`true = internal` or `false = internet-facing`"
  type        = bool
  default     = true
}

variable "ip_address_type" {
  description = "NLB가 사용할 IP 주소타입 `ipv4` or `dualstack`"
  type        = string
  default     = "ipv4"
}

variable "subnets" {
  description = "LB가 배치될 Subnet ID 목록"
  type        = list(string)
  default = null
}

variable "subnet_mappings" {
  description = "고정 IP 지정이 필요할 때 subnet mapping  subnet_id => private_ip"
  type = map(string)
  default = null
}

variable "security_groups" {
  description = "NLB가 구성방식에 따라 적용할 보안 그룹 목록"
  type        = list(string)
  default     = []
}

variable "enable_cross_zone_load_balancing" {
  description = "Cross-Zone Load Balancing 기능 활성화 여부"
  type        = bool
  default     = true
}

variable "enable_deletion_protection" {
  description = "NLB 삭제 방지 기능 활성화 여부"
  type        = bool
  default     = true
}

variable "dns_record_client_routing_policy" {
  description = "DNS 레코드 라우팅 정책 지정"
  type        = string
  default     = null
}

variable "tags" {
  description = "NLB에 적용될 태그"
  type        = map(string)
  default     = {}
}

# Access Log
variable "access_log_enabled" {
  description = "Access Log 기능 활성화 여부"
  type        = bool
  default     = true
}

variable "access_log_prefix" {
  description = "Access Log를 저장할 S3 경로에 적용되는 Prefix"
  type        = string
  default     = null
}

variable "access_log_bucket_name" {
  description = "Access Log 버킷 이름, 지정하지 않으면 자동 생성"
  type = string
  default = null
}

# listner
variable "listeners" {
  description = "Listener 목록"
  type = list(object({
    port             = number
    protocol         = string
    target_group_arn = optional(string)
    ssl_policy       = optional(string)
    certificate_arn  = optional(string)
  }))
}

variable "secondary_certificate" {
  description = "TLS 리스터 사용 시 등록할 추가 인증서 목록"
  type = list(object({
    port     = optional(number, null)
    protocol = optional(string, null)
    cert     = optional(string, null)
  }))
  default = []
}
