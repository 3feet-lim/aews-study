########################
# EKS Addons
########################

# VPC CNI addon (Custom Networking 활성화)
module "eks_addon" {
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

  depends_on = [module.eks_addon]
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

  depends_on = [module.eks_addon]
}
