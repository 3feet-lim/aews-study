########################
# EKS Addons (노드그룹 전)
########################

# VPC CNI + Pod Identity Agent (노드 뜨기 전에 Custom Networking 설정 필요)
module "eks_addon_pre_node" {
  source = "../../modules/terraform-aws-eks-addon"

  cluster_name = module.eks.name

  addon = [
    {
      addon_name = "vpc-cni"
      configuration_values = jsonencode({
        env = {
          AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG = "true"
          ENI_CONFIG_LABEL_DEF               = "topology.kubernetes.io/zone"
        }
      })
    },
    { addon_name = "eks-pod-identity-agent" },
  ]

  depends_on = [module.eks]
}

########################
# ENIConfig (Custom Networking)
########################

# AZ-a 용 ENIConfig
resource "kubernetes_manifest" "eniconfig_az1" {
  manifest = {
    apiVersion = "crd.k8s.amazonaws.com/v1alpha1"
    kind       = "ENIConfig"
    metadata = {
      name = "ap-northeast-2a"
    }
    spec = {
      securityGroups = [module.eks_node_sg.id]
      subnet         = module.pod_subnets.subnets["${var.project_name}-pod-a-1"].id
    }
  }

  depends_on = [module.eks_addon_pre_node]
}

# AZ-c 용 ENIConfig
resource "kubernetes_manifest" "eniconfig_az3" {
  manifest = {
    apiVersion = "crd.k8s.amazonaws.com/v1alpha1"
    kind       = "ENIConfig"
    metadata = {
      name = "ap-northeast-2c"
    }
    spec = {
      securityGroups = [module.eks_node_sg.id]
      subnet         = module.pod_subnets.subnets["${var.project_name}-pod-c-1"].id
    }
  }

  depends_on = [module.eks_addon_pre_node]
}

########################
# EKS Addons (노드그룹 후)
########################

# CoreDNS + kube-proxy (노드가 있어야 ACTIVE 됨)
module "eks_addon_post_node" {
  source = "../../modules/terraform-aws-eks-addon"

  cluster_name = module.eks.name

  addon = [
    { addon_name = "kube-proxy" },
    { addon_name = "coredns" },
  ]

  depends_on = [module.eks_ng]
}
