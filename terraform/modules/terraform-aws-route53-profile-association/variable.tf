variable "name" {
  description = "Route53 Profile Association 이름"
  type        = string
}

variable "profile_id" {
  description = "Route53 Profile Association Profile ID"
  type        = string
}

variable "resource_id" {
  description = "Route53 Profile Association 대상 리소스 ID"
  type        = string
}

variable "tags" {
  description = "Route53 Profile Association Tags"
  type        = map(string)
  default     = null
}