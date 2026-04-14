
# External Prefix IP INFO
output "prefix_list" {
  value = aws_ec2_managed_prefix_list.this
}


# External Prefix IP INFO
output "id" {
  value = aws_ec2_managed_prefix_list.this.id
}
