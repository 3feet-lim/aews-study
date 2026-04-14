# Internal PREFIX 이름
variable "name" {
  description = "관리형 접두사 목록 IP 이름"
  type        = string
}

# INternal PREFIX 갯수
variable "max_entries" {
  description = "관리형 접두사 IP 목록 최대 갯수"
  type        = number
}

# External PREFIX IP 목록
variable "entry" {
  description = "관리형 접두사 IP 목록"
  type = list(object({
    cidr        = string
    description = optional(string)
  }))
  default = []
}