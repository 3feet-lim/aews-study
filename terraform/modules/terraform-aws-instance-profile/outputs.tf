output "instance-profile" {
  value = aws_iam_instance_profile.this
}

output "role" {
  value = aws_iam_role.this
}

output "role_name" {
  description = "Instance Profile에 연결된 IAM Role 이름"
  value       = aws_iam_role.this.name
}

output "instance_profile_name" {
  description = "Instance Profile 이름"
  value       = aws_iam_instance_profile.this.name
}

output "arn" {
  description = "Instance Profile에 연결된 IAM Role ARN"
  value       = aws_iam_role.this.arn
}
