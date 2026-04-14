output "eni_ids" {
  description = "생성된 ENI ID"
  value = {
    for k, eni in aws_network_interface.this : k => eni.id
  }
}

output "eni_primary_private_ips" {
  description = "각 ENI의 기본 private IP"
  value = {
    for k, eni in aws_network_interface.this : k => eni.private_ip
  }
}

output "eni_all_private_ips" {
  description = "각 ENI의 모든 private IP 목록"
  value = {
    for k, eni in aws_network_interface.this : k => eni.private_ips
  }
}