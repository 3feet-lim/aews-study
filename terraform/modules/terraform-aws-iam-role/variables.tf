variable "name" {
  description = "역할권한 이름"
  type        = string
}

variable "description" {
  description = "역할권한 설명"
  type        = string
  default     = null
}

variable "assume_role_policy" {
  description = "역할권한 Trusted Policy"
  type        = string
}

variable "policy_arns" {
  description = "policy ARNs 목록"
  type        = list(string)
  default     = []
}