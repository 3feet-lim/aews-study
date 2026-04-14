variable "name" {
  description = "EKS 클러스터 이름"
  type        = string
}

# 모듈 변수 version과 충돌로인해 해당 변수명으로 사용
variable "eks_version" {
  description = "EKS 클러스터 버전"
  type        = string
}

variable "role_arn" {
  description = "EKS 클러스터의 역할권한 ARN"
  type        = string
}

variable "authentication_mode" {
  description = "EKS 클러스터의 인증권한 모드"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "bootstrap_cluster_creator_admin_permissions" {
  description = "EKS 클러스터의 부트스르랩 여부"
  type        = bool
  default     = true
}

variable "key_arn" {
  description = "EKS 클러스터의 암호화 Key"
  type        = string
  default     = null
}

variable "tags" {
  description = "EKS 클러스터의 태그"
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  description = "EKS 클러스터가 배치되는 Subnet ID"
  type        = list(string)
}

variable "security_group_ids" {
  description = "EKS 클러스터에 설정되는 추가 보안 그룹 ID"
  type        = list(string)
  default     = []
}

variable "endpoint_public_access" {
  description = "EKS 클러스터 Public 접근 여부"
  type        = bool
  default     = false
}

variable "endpoint_private_access" {
  description = "EKS 클러스터 Private 접근 여부"
  type        = bool
  default     = true
}

variable "service_ipv4_cidr" {
  description = "EKS 클러스터의 서비스 IP CIDR"
  type        = string
  default     = "172.20.0.0/16"
}

variable "enabled_cluster_log_types" {
  description = "EKS 클러스터의 로그 활성화 및 대상"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "support_type" {
  description = "EKS 클러스터의 Support 타입"
  type        = string
  default     = "STANDARD"
}

variable "thumbprint_list" {
  description = "EKS OIDC Provider Thumbprint 리스트"
  type        = list(string)
  default     = []
}

# access list 구성 정보
variable "access_entry" {
  description = "EKS 클러스터의 Access Entry 목록"
  type = list(object({
    principal_arn     = string
    policy_arn        = string
    type              = optional(string)
    scope_type        = optional(string)
    kubernetes_groups = optional(list(string))
  }))
  default = []
}

variable "ip_family" {
  description = "EKS 클러스터의 IP 패밀리"
  type        = string
  default     = "ipv4"
}

variable "bootstrap_self_managed_addons" {
  description = "클러스터 생성 시, aws-cni, kube-proxy, coreDNS 등의 기본 unmanaged add-on 자동 설치 여부"
  type        = bool
  default     = true
}

variable "cluster_log_enable" {
  description = "EKS 클러스터 로그 활성화 여부"
  type        = bool
  default     = true
}

variable "retention_in_days" {
  description = "EKS 클러스터 로그 보관 기간"
  type        = number
  default     = 7
}