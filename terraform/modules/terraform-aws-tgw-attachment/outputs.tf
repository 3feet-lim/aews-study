output "id" {
  description = "생성된 Transit Gateway VPC Attachment의 ID"
  value       = aws_ec2_transit_gateway_vpc_attachment.this.id
}