# natgateway 구성 정보
variable "natgateway" {
  description = "Nat Gateway 설정 목록"
  type = list(object({
    name              = string
    subnet_id         = string
    connectivity_type = optional(string, "private")
  }))
  default = []
}

variable "tags" {
  description = "Nat Gateway 태그"
  type        = map(string)
  default     = {}
}

variable "eip_tags" {
  description = "EIP 태그"
  type        = map(string)
  default     = {}
}
