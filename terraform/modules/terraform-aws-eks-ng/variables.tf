# EKS Cluster INFO
variable "cluster_name" {
  description = "NodeGroup이 연결될 eks 클러스터 이름"
  type        = string
}

# EKS Workernode INFO
variable "node_group_name" {
  description = "EKS Node Group 이름"
  type        = string
}

variable "node_role_arn" {
  description = "Worker node가 사용할 IAM Role arn"
  type        = string
}

variable "subnet_ids" {
  description = "Worker node가 배치될 서브넷 IDs"
  type        = list(string)
}

variable "tags" {
  description = "Node Group에 적용할 태그"
  type        = map(string)
  default     = {}
}

variable "min_size" {
  description = "Auto scaling 최소 노드 수"
  type        = number
}

variable "max_size" {
  description = "Auto scaling 최대 노드 수"
  type        = number
}

variable "desired_size" {
  description = "Auto scaling 목표 노드 수"
  type        = number
}

variable "update_config" {
  description = "Roling 업데이트 설정. 최대로 사용할 수 없는 노드의 수 또는 비율 지정"
  type = object({
    max_unavailable            = optional(number)
    max_unavailable_percentage = optional(number)
  })
  default = {}

  validation {
    condition     = !(var.update_config.max_unavailable != null && var.update_config.max_unavailable_percentage != null)
    error_message = "max_unavailable과 max_unavailable_percentage 중 하나만 지정이 되어야 합니다."
  }
}

variable "labels" {
  description = "노드에 적용할 Kubernetes Labels"
  type        = map(string)
  default     = {}
}

variable "taints" {
  description = "노드에 적용할 Kubernetes tains"
  type = list(object({
    key    = string
    value  = optional(string)
    effect = string
  }))
  default = []
}

variable "launch_template_name" {
  description = "Launch Template 이름"
  type        = string
  default     = null
}

variable "launch_template_version" {
  description = "Launch Template 버전"
  type        = number
  default     = null
}
