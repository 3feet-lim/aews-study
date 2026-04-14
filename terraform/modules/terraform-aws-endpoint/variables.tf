# VPC INFO
variable "vpc_id" {
  description = "VPC Endpoint가 배치될 VPC ID"
  type        = string
}

variable "vpce_list" {
  description = "VPC Endpoint 목록(Gateway/Interface)"
  type = list(object({
    service_name        = string
    vpc_endpoint_type   = string
    route_table_ids     = optional(list(string))
    subnet_ids          = optional(list(string))
    security_group_ids  = optional(list(string))
    private_dns_enabled = optional(bool, true)
    vpce_name           = string
  }))
  default = []
}

variable "private_dns_only_for_inbound_resolver_endpoint" {
  description = "인바운드 리졸버 엔드포인트 경로에서만 Private DNS 사용 제한 여부"
  type        = bool
  default     = true
}

variable "tags" {
  description = "VPC Endpoint 태그"
  type = map(string)
  default = {}
}
