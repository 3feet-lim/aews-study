output "arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.this.arn
}

output "name" {
  description = "Target Group Name"
  value       = aws_lb_target_group.this.name
}

output "id" {
  description = "Target Group ID"
  value       = aws_lb_target_group.this.id
}