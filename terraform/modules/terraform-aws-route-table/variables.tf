variable "vpc_id" {
  description = "vpc ID"
  type        = string
}

variable "name" {
  description = "Route Table 이름"
  type        = string
}

variable "subnet_ids" {
  description = "Route Table 연결할 subnet id"
  type        = list(string)
  default     = []
}

variable "routes" {
  description = "라우팅 정보"
  type = list(object({
    destination_cidr_block     = optional(string)
    destination_prefix_list_id = optional(string)
    gateway_id                 = optional(string)
    nat_gateway_id             = optional(string)
    network_interface_id       = optional(string)
    transit_gateway_id         = optional(string)
    vpc_endpoint_id            = optional(string)
    vpc_peering_connection_id  = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "Route Table 태그"
  type        = map(string)
  default     = {}
}