########################
# 출력값
########################

output "eks_cluster_name" {
  value = module.eks.name
}

output "eks_cluster_endpoint" {
  value = module.eks.endpoint
}

output "eks_cluster_certificate_authority" {
  value = module.eks.certificate_authority
}

output "eks_oidc_arn" {
  value = module.eks.oidc_arn
}

output "vpc_id" {
  value = module.vpc.id
}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${var.target_region} update-kubeconfig --name ${var.project_name}-eks"
}
