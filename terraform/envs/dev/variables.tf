########################
# 입력 변수
########################

variable "project_name" {
  description = "프로젝트 이름"
  type        = string
  default     = "smlim-gitops-dev"
}

variable "target_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-northeast-2"
}

variable "vpc_block" {
  description = "VPC CIDR 대역"
  type        = string
  default     = "10.140.32.0/24"
}

variable "github_token" {
  description = "GitHub Personal Access Token (FluxCD Git 인증용)"
  type        = string
  sensitive   = true
}

variable "flux_git_url" {
  description = "FluxCD가 watch할 Git repository URL"
  type        = string
}

variable "flux_git_branch" {
  description = "FluxCD가 watch할 Git branch"
  type        = string
  default     = "main"
}

variable "flux_git_path" {
  description = "FluxCD가 동기화할 Git repository 내 경로"
  type        = string
  default     = "./clusters/dev"
}

variable "flux_bootstrap_enabled" {
  description = "FluxCD bootstrap CRD 배포 여부 (첫 apply 시 false, Helm 설치 후 true로 변경)"
  type        = bool
  default     = false
}
