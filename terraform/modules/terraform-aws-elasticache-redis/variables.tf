variable "name" {
  description = "Redis 클러스터 이름"
  type        = string
}

variable "description" {
  description = "Redis 클러스터에 대한 설명"
  type        = string
}

variable "engine_version" {
  description = "Redis OSS 엔진 버전"
  type        = string
  default     = "7.1"
}

variable "port" {
  description = "Redis 연결에 사용할 포트"
  type        = number
  default     = 6379
}

variable "automatic_failover_enabled" {
  description = "다중 노드 구성 시 자동 장애 조치 활성화 여부"
  type        = bool
  default     = true
}

# dev만 false
variable "multi_az_enabled" {
  description = "Multi-AZ 활성화 여부"
  type        = bool
  default     = false
}

variable "node_type" {
  description = "Redis 노드의 인스턴스 type"
  type        = string
}

variable "cluster_mode" {
  description = "Redis 클러스터 모드"
  type        = string
  default     = "enabled"
}

variable "num_node_groups" {
  description = "Redis 클러스터의 노드 그룹 수"
  type        = number
  default     = 1
}

variable "replicas_per_node_group" {
  description = "Redis 클러스터의 노드 그룹당 복제본 수"
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

variable "at_rest_encryption_enabled" {
  description = "Redis 데이터 저장 시 암호화 활성화 여부"
  type        = bool
  default     = true
}

variable "transit_encryption_enabled" {
  description = "전송 중 데이터 암호화(TLS) 활성화 여부"
  type        = bool
  default     = true
}

variable "auth_token" {
  description = "Redis 접근에 사용하는 auth Token. transit encryption 활성화 시 필수"
  type        = string
  default     = null
  sensitive   = true

  validation {
    condition = (
      var.auth_token == null ||
      (try(length(var.auth_token), 0) >= 16 && try(length(var.auth_token), 0) <= 128)
    )
    error_message = "auth_token must be 16-128 characters when provided"
  }
}

variable "auth_token_update_strategy" {
  description = "Auth Token 갱신 방식"
  type        = string
  default     = null

  validation {
    condition = (
      (var.auth_token == null && var.auth_token_update_strategy == null) || (var.auth_token != null)
    )
    error_message = "auth_token 를 설정하면 필수로 설정해야합니다."
  }
}

variable "kms_key_id" {
  description = "Redis 데이터 암호화에 사용할 kms key ID. `at_rest_incryption_enabled = true` 일 때 필수"
  type        = string
  default     = null
}

variable "snapshot_retention_limit" {
  description = "자동 백업(snapshot)을 보관할 기간(일)"
  type        = number
  default     = 30
}

variable "snapshot_window" {
  description = "자동 스냅샷이 수행되는 시간대 (UTC)"
  type        = string
  default     = "14:00-15:00"
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


# Subnet Group
variable "subnet_ids" {
  description = "Redis 클러스터가 배치될 Subnet ID 목록"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "subnet group 이름"
  type        = string
  default     = null
}

variable "subnet_group_tags" {
  description = "Subnet Group 태그"
  type        = map(string)
  default     = {}
}

variable "subnet_group_description" {
  description = "Subnet Group 설명"
  type        = string
  default     = null
}


# Parameter Group
variable "parameter_group_list" {
  description = "Parameter Group 이름 목록"
  type        = map(string)
  default     = {}
}

variable "parameter_group_name" {
  description = "Parameter Group 이름"
  type        = string
  default     = "default-redis7"
}

variable "parameter_group_description" {
  description = "Parameter group에 대한 설명"
  type        = string
  default     = "Default Redis 7 parameter group"
}

variable "parameter_group_family" {
  description = "Redis 엔진 버전에 따른 Parameter Group 계열명"
  type        = string
  default     = "redis7"
}