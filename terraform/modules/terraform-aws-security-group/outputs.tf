# SG의 Info
output "sg" {
  value = aws_security_group.this
}

# SG의 ID
output "id" {
  value = aws_security_group.this.id
}