variable "alias" {
  description = "KMS Key Alias(별칭)"
  type        = string
}

variable "description" {
  description = "KMS key 설명"
  type        = string
  default     = "Managed by Terraform"
}

variable "enable_key_rotation" {
  description = "KMS Key 자동 변경 여부"
  type        = bool
  default     = true
}

variable "rotation_period_in_days" {
  description = "KMS Key 변경 주기"
  type        = number
  default     = 365
}

variable "policy" {
  description = "KMS key 정책"
  type        = string
  default     = null
}

variable "tags" {
  description = "KMS key 태그"
  type        = map(string)
  default     = {}
}