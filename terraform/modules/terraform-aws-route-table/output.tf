# RouteTable INFO
output "id" {
  description = "Route Table ID"
  value       = aws_route_table.this.id
}

output "arn" {
  description = "Route Table ARN"
  value       = aws_route_table.this.arn
}
