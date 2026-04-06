########################
# ENIConfig for Custom Networking
########################

resource "kubernetes_manifest" "eniconfig" {
  for_each = {
    for idx, az in var.availability_zones : az => module.vpc.intra_subnets[idx]
  }

  manifest = {
    apiVersion = "crd.k8s.amazonaws.com/v1alpha1"
    kind       = "ENIConfig"
    metadata = {
      name = each.key
    }
    spec = {
      securityGroups = [module.eks.node_security_group_id]
      subnet         = each.value
    }
  }

  depends_on = [module.eks]
}

########################
# Karpenter NodePool + EC2NodeClass
# 1차 apply 후 주석 해제하여 2차 apply
########################

resource "kubernetes_manifest" "karpenter_node_class" {
  manifest = {
    apiVersion = "karpenter.k8s.aws/v1"
    kind       = "EC2NodeClass"
    metadata = {
      name = "default"
    }
    spec = {
      amiSelectorTerms = [{
        alias = "al2023@latest"
      }]
      role = aws_iam_role.karpenter_node.name
      subnetSelectorTerms = [{
        tags = {
          "Name" = "${var.ClusterBaseName}-PrivateSubnet"
        }
      }]
      securityGroupSelectorTerms = [{
        tags = {
          "aws:eks:cluster-name" = var.ClusterBaseName
        }
      }]
      tags = {
        "karpenter.sh/discovery" = var.ClusterBaseName
      }
    }
  }

  depends_on = [helm_release.karpenter]
}

resource "kubernetes_manifest" "karpenter_node_pool" {
  manifest = {
    apiVersion = "karpenter.sh/v1"
    kind       = "NodePool"
    metadata = {
      name = "default"
    }
    spec = {
      template = {
        spec = {
          nodeClassRef = {
            group = "karpenter.k8s.aws"
            kind  = "EC2NodeClass"
            name  = "default"
          }
          requirements = [
            {
              key      = "kubernetes.io/arch"
              operator = "In"
              values   = ["amd64"]
            },
            {
              key      = "karpenter.sh/capacity-type"
              operator = "In"
              values   = ["on-demand", "spot"]
            },
            {
              key      = "karpenter.k8s.aws/instance-category"
              operator = "In"
              values   = ["c", "m", "r", "t"]
            },
            {
              key      = "karpenter.k8s.aws/instance-generation"
              operator = "Gt"
              values   = ["2"]
            },
            {
              key      = "karpenter.k8s.aws/instance-size"
              operator = "NotIn"
              values   = ["nano", "micro"]
            }
          ]
        }
      }
      limits = {
        cpu    = "100"
        memory = "200Gi"
      }
      disruption = {
        consolidationPolicy = "WhenEmptyOrUnderutilized"
        consolidateAfter    = "1m"
      }
    }
  }

  depends_on = [kubernetes_manifest.karpenter_node_class]
}
