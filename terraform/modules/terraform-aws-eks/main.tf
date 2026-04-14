####################################################################
# Module Name : EKS Cluster
# Module Desc : EKS Cluster를 생성합니다.
####################################################################

####################################################################
# EKS Cluster 생성
####################################################################
resource "aws_eks_cluster" "this" {

  name                          = var.name
  version                       = var.eks_version
  role_arn                      = var.role_arn
  enabled_cluster_log_types     = var.enabled_cluster_log_types
  bootstrap_self_managed_addons = var.bootstrap_self_managed_addons

  access_config {
    authentication_mode                         = var.authentication_mode
    bootstrap_cluster_creator_admin_permissions = var.bootstrap_cluster_creator_admin_permissions
  }

  vpc_config {
    security_group_ids      = var.security_group_ids
    subnet_ids              = var.subnet_ids
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.service_ipv4_cidr
    ip_family         = var.ip_family
  }

  dynamic "encryption_config" {
    for_each = (
      var.key_arn != null && var.key_arn != "" ? [1] : []
    )

    content {
      provider {
        key_arn = var.key_arn
      }
      resources = ["secrets"]
    }
  }

  upgrade_policy {
    support_type = var.support_type
  }
  tags = merge(
    { Name = var.name },
    var.tags
  )
}

# OIDC ThumbPrint 조회
data "tls_certificate" "eks-cluster-oidc-url" {
  count = length(var.thumbprint_list) == 0 ? 1 : 0
  url   = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

# OIDC 등록
resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = length(var.thumbprint_list) == 0 ? [data.tls_certificate.eks-cluster-oidc-url[0].certificates[0].sha1_fingerprint] : var.thumbprint_list
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

# EKS Access 등록
resource "aws_eks_access_entry" "this" {
  #for_each     = { for access in var.eks_iam_access : "${access.principal_arn}" => access}
  for_each = { for idx, v in var.access_entry : idx => v }

  cluster_name      = aws_eks_cluster.this.id
  principal_arn     = each.value.principal_arn
  type              = try(each.value.type, "STANDARD")
  kubernetes_groups = try(each.value.kubernetes_groups, null)

  lifecycle {
    create_before_destroy = true
  }
}

# EKS Access Association 설정 
resource "aws_eks_access_policy_association" "this" {
  #for_each = { for access in var.eks_iam_access : "${access.principal_arn}" => access}
  for_each = { for idx, v in var.access_entry : idx => v }

  cluster_name  = aws_eks_cluster.this.id
  principal_arn = each.value.principal_arn
  policy_arn    = try(each.value.policy_arn, "cluster")

  access_scope {
    type = try(each.value.scope_type, "cluster")
  }

  depends_on = [aws_eks_access_entry.this]

  lifecycle {
    create_before_destroy = true
  }
}

# EKS Log group 설정
resource "aws_cloudwatch_log_group" "this" {
  count             = var.cluster_log_enable ? 1 : 0
  name              = "/aws/eks/${var.name}/cluster"
  retention_in_days = var.retention_in_days
}