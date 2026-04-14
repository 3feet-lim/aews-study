variable "addon_versions" {
  type        = map(string)
  description = "EKS ADDON 기본 버전"
  default = {
    vpc-cni            = "v1.20.4-eksbuild.1"
    coredns            = "v1.11.4-eksbuild.2"
    kube-proxy         = "v1.32.6-eksbuild.12"
    aws-efs-csi-driver = "v2.1.13-eksbuild.1"
    aws-ebs-csi-driver = "v1.51.1-eksbuild.1"
  }
}

variable "addon" {
  description = "EKS ADDON 목록"
  type = list(object({
    addon_name               = string
    addon_version            = optional(string)
    service_account_role_arn = optional(string)
    configuration_values     = optional(string)
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
  }))
  default = []
}

variable "cluster_name" {
  description = "EKS ADDON 배포대상 EKS 클러스터"
  type        = string
}

