variable "cluster_id" {
  description = "Redis Cluster 이름"
  type        = string
}

variable "engine_version" {
  description = "Redis OSS Engine 버전"
  type        = string
  default     = "6.2"
}

variable "port" {
  description = "Redis 연결에 사용할 포트"
  type        = number
  default     = 6379
}

variable "node_type" {
  description = "Redis 노드의 인스턴스 type"
  type        = string
}

variable "num_cache_nodes" {
  description = "클러스터 내 캐시 노드 수"
  type        = number
  default     = 1
}

variable "security_group_ids" {
  description = "Redis 클러스터가 속할 보안그룹 ID"
  type        = list(string)
  default     = []
}

variable "apply_immediately" {
  description = "구성 변경 즉시 적용 여부, false 일 경우 유지보수 시간대에 적용"
  type        = bool
  default     = true
}

variable "transit_encryption_enabled" {
  description = "전송 중 데이터 암호화(TLS) 활성화 여부"
  type        = bool
  default     = true
}

variable "snapshot_retention_limit" {
  description = "자동 백업(snapshot)을 보관할 기간(일)"
  type        = number
  default     = 30
}

variable "snapshot_window" {
  description = "자동 스냅샷이 수행되는 시간대 (UTC)"
  type        = string
  default     = "15:00-16:00"
}

variable "auto_minor_version_upgrade" {
  description = "자동 minor 버젼 업그레이드 여부"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "유지보수가 수행되는 시간대 (UTC)"
  type        = string
  default     = "sun:15:00-sun:16:00"
}

variable "cluster_tags" {
  description = "Redis 클러스터 태그"
  type        = map(string)
  default     = {}
}

variable "log_delivery_configuration" {
  description = "Log Delivery 설정 목록"
  type = list(object({
    destination      = optional(string)
    destination_type = optional(string, "cloudwatch-logs")
    log_format       = optional(string, "json")
    log_type         = optional(string, "slow-log")
  }))
  default = []
}


# Parameter Group
variable "parameter_group_name" {
  description = "Parameter Group 이름"
  type        = string
  default     = "default.redis6"
}

variable "parameter_group_description" {
  description = "Parameter group에 대한 설명"
  type        = string
  default     = "default.redis6"
}

variable "parameter_group_family" {
  description = "Redis 엔진 버전에 따른 Parameter Group 계열명"
  type        = string
  default     = "redis6"
}

variable "parameter_group_list" {
  description = "Parameter Group 이름 목록"
  type        = map(string)
  default     = {}
}


# Subnet group
variable "subnet_ids" {
  description = "Redis 클러스터가 배치될 Subnet ID 목록"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "subnet group 이름"
  type        = string
  default     = ""
}

variable "subnet_group_description" {
  description = "Subnet group에 대한설명"
  type        = string
  default     = ""
}

variable "subnet_group_tags" {
  description = "Subnet Group 태그"
  type        = map(string)
  default     = {}
}
