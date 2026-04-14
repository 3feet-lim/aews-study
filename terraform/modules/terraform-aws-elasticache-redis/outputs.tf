output "id" {
  description = "Replication Group ID"
  value       = aws_elasticache_replication_group.this.id
}

output "primary_endpoint_address" {
  description = "Primary endpoint"
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
}

output "reader_endpoint_address" {
  description = "Reader endpoint"
  value       = aws_elasticache_replication_group.this.reader_endpoint_address
}

output "configuration_endpoconfiguration_endpoint_address" {
  description = "Configuration endpoint"
  value       = aws_elasticache_replication_group.this.configuration_endpoint_address
}

output "subnet_group_name" {
  description = "Subnet group name used by Redis"
  value       = aws_elasticache_subnet_group.this.name
}