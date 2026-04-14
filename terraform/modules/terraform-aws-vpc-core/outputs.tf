# VPC Info
output "vpc" {
  description = "The Info of the VPC"
  value       = aws_vpc.this
}

# VPC ID
output "id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

# IGW ID
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = length(aws_internet_gateway.this) > 0 ? aws_internet_gateway.this[0].id : null
}