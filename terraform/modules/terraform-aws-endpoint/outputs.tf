# Endpoint INFO

output "endpoint_gateway" {
  value = aws_vpc_endpoint.endpoint_gateway
}

output "endpoint_interface" {
  value = aws_vpc_endpoint.endpoint_interface
}
