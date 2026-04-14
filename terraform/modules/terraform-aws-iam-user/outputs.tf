output "name" {
  description = "IAM user name"
  value       = aws_iam_user.this.name
}

output "arn" {
  description = "IAM user ARN"
  value       = aws_iam_user.this.arn
}
