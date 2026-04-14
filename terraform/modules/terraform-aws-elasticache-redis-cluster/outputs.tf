output "id" {
  description = "Replication Group ID"
  value       = aws_elasticache_cluster.this.id
}

output "endpoint" {
  description = "Primary endpoint"
  value       = aws_elasticache_cluster.this.cache_nodes[0].address
}

output "parameter_group_name" {
  description = "Parameter Group 이름"
  value       = aws_elasticache_parameter_group.this.name
}

output "subnet_group_name" {
  description = "Subnet group 이름"
  value       = aws_elasticache_subnet_group.this.name
}