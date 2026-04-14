variable "name" {
  description = "IAM user name"
  type        = string
}

variable "path" {
  description = "Path for the IAM user"
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "Force destroy user even if it has keys or logins"
  type        = bool
  default     = false
}

variable "groups" {
  description = "List of IAM group names to add this user to"
  type        = list(string)
  default     = []
}