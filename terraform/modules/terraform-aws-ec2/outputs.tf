output "ec2" {
  value = aws_instance.this
}

output "id" {
  description = "EC2 인스턴스 id"
  value       = aws_instance.this.id
}

output "arn" {
  description = "EC2 인스턴스 arn"
  value       = aws_instance.this.arn
}