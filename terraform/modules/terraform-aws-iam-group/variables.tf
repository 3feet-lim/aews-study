variable "name" {
  description = "Name of IAM group"
  type        = string
}

variable "path" {
  description = "Path for IAM group"
  type        = string
  default     = "/"
}

variable "policy_arns" {
  description = "List of IAM policy ARNs to attach to the group"
  type        = list(string)
  default     = []
}