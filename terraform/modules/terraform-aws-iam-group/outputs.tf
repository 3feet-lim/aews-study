output "iam_group_name" {
  description = "IAM group name"
  value       = aws_iam_group.this.name
}

output "iam_group_arn" {
  description = "IAM group ARN"
  value       = aws_iam_group.this.arn
}