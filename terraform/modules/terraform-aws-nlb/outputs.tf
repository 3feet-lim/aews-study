output "arn" {
  description = "NLB ARN"
  value       = aws_lb.this.arn
}

output "dns_name" {
  description = "NLB DNS 이름(Route53 alias 설정 시 사용)"
  value       = aws_lb.this.dns_name
}