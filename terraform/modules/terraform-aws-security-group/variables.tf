# SG Name
variable "name" {
  description = "보안 그룹 이름"
  type        = string
}

# VPC ID
variable "vpc_id" {
  description = "보안 그룹이 배치되는 VPC ID"
  type        = string
}

# SG DESC
variable "description" {
  description = "보안 그룹 설명"
  type        = string
}

# SG IN Protocol
variable "ingress" {
  description = "Inbound 정책 목록"
  type = map(object({
    from_port                    = string
    to_port                      = string
    ip_protocol                  = string
    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    referenced_security_group_id = optional(string)
    prefix_list_id               = optional(string)
    description                  = optional(string)
    self                         = optional(bool)
    tags                         = optional(map(string))
  }))
  default = {}
}

# SG OUT Protocol
variable "egress" {
  description = "Outbound 정책 목록"
  type = map(object({
    from_port                    = string
    to_port                      = string
    ip_protocol                  = string
    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    referenced_security_group_id = optional(string)
    prefix_list_id               = optional(string)
    description                  = optional(string)
    self                         = optional(bool)
    tags                         = optional(map(string))
  }))
  default = {}
}

variable "revoke_rules_on_delete" {
  description = "보안 그룹 삭제 시 규칙 자동 해제 여부"
  type        = bool
  default     = true
}

variable "tags" {
  description = "보안 그룹 태그"
  type        = map(string)
  default     = {}
}
