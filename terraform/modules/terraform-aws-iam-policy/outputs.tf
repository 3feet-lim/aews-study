output "policy" {
  value = aws_iam_policy.this
}

output "arn" {
  description = "IAM Policy ARN"
  value       = aws_iam_policy.this.arn
}
