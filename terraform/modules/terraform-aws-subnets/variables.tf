# VPC NAME
variable "vpc_id" {
  description = "서브넷이 배치되는 VPC ID"
  type        = string
}

# SUBNET 구성 정보
variable "subnets" {
  description = "서브넷 설정 목록"
  type = list(object({
    name                    = string
    availability_zone_id    = string
    cidr_block              = string
    map_public_ip_on_launch = optional(bool, false)
    tags                    = optional(map(string))
  }))
  default = []
}
