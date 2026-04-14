variable "name" {
  description = "Attachment에 이름"
  type        = string
}

variable "transit_gateway_id" {
  description = "공유된 TGW ID"
  type        = string
}

variable "vpc_id" {
  description = "TGW와 연결할 VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Attachment에 사용할 subnet ID 리스트"
  type        = list(string)
}

variable "appliance_mode_support" {
  description = "Appliance 모드 지원 활성화 여부"
  type        = string
  default     = "disable"
}

variable "dns_support" {
  description = "DNS 지원 활성화 여부"
  type        = string
  default     = "enable"
}

variable "ipv6_support" {
  description = "IPv6 지원 활성화 여부"
  type        = string
  default     = "disable"
}

variable "tags" {
  description = "TGW Attachment 추가 할당 태그"
  type        = map(string)
  default     = {}
}