output "id" {
  description = "Launch Template ID"
  value       = aws_launch_template.this.id
}

output "name" {
  description = "Launch Template 이름"
  value       = aws_launch_template.this.name
}

output "latest_version" {
  description = "Launch Template 최신 버전"
  value       = aws_launch_template.this.latest_version
}

output "default_version" {
  description = "Launch Template 기본 버전"
  value       = aws_launch_template.this.default_version
}