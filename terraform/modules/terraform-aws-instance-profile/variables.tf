variable "name" {
  description = "iam role, Instance Profile 이름"
  type        = string
}

variable "description" {
  description = "iam role 에 대한 설명"
  type        = string
  default     = null
}

variable "assume_role_policy" {
  description = "ec2 profile truested policy"
  type        = string
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

variable "policy_arns" {
  description = "policy ARNs 목록"
  type        = list(string)
  default     = []
}
