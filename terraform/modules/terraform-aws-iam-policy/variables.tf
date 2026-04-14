variable "name" {
  description = "정책 이름"
  type        = string
}

variable "path" {
  description = "정책 경로"
  type        = string
  default     = "/"
}

variable "description" {
  description = "정책 설명"
  type        = string
  default     = null
}


variable "policy" {
  description = "정책 권한"
  type        = string
  default     = null
}