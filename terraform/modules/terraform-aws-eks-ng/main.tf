####################################################################
# Module Name : EKS Cluster WorkerNode
# Module Desc : EKS Cluster WorkerNode를 생성합니다.
####################################################################

# ##################################
# # EKS Cluster Node Group
# ##################################
resource "aws_eks_node_group" "this" {

  node_group_name = var.node_group_name
  cluster_name    = var.cluster_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  tags            = var.tags
  labels          = var.labels

  dynamic "taint" {
    for_each = var.taints != null ? var.taints : []
    content {
      key    = lookup(taint.value, "key", null)
      value  = lookup(taint.value, "value", null)
      effect = lookup(taint.value, "effect", null)
    }
  }

  scaling_config {
    min_size     = var.min_size
    max_size     = var.max_size
    desired_size = var.desired_size
  }

  launch_template {
    name    = var.launch_template_name
    version = var.launch_template_version
  }

  update_config {
    max_unavailable_percentage = lookup(var.update_config, "max_unavailable_percentage", null)
    max_unavailable            = lookup(var.update_config, "max_unavailable", null)
  }

  lifecycle {
    create_before_destroy = true
  }
}

