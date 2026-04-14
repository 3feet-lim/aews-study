# EKS 정보
output "eks" {
  value = aws_eks_cluster.this
}

# EKS 이름
output "name" {
  value = aws_eks_cluster.this.name
}

# EKS Endpoint
output "endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "arn" {
  value = aws_eks_cluster.this.arn
}

# EKS Certificate authority
output "certificate_authority" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

# EKS Service IP Cidr
output "service_ipv4_cidr" {
  value = aws_eks_cluster.this.kubernetes_network_config[0].service_ipv4_cidr
}

# EKS OIDC 정보
output "oidc" {
  value = aws_iam_openid_connect_provider.this
}

# EKS OIDC ARN
output "oidc_arn" {
  value = aws_iam_openid_connect_provider.this.arn
}

# EKS OIDC URL
output "url" {
  value = aws_iam_openid_connect_provider.this.url
}