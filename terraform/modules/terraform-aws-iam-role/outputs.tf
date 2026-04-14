output "role" {
  value = aws_iam_role.this
}

output "arn" {
  description = "IAM Role ARN"
  value       = aws_iam_role.this.arn
}
