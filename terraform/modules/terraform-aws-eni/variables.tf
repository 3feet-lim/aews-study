variable "enis" {
  description = "생성하게 되는  ENI를 정의하는 map"
  type = map(object({
    description                = optional(string, null)
    subnet_id                  = string
    security_group_ids         = optional(list(string), [])
    private_ip                 = optional(string, null)
    secondary_private_ips      = optional(list(string), [])
    secondary_private_ip_count = optional(number, null)
    ipv6_address_count         = optional(number, 0)
    ipv6_addresses             = optional(list(string), [])
    source_dest_check          = optional(bool, true)
    interface_type             = optional(string, null)
    attachment = optional(object({
      instance_id           = string
      device_index          = number
      delete_on_termination = optional(bool, true)
    }))
  }))
  default = null
}

