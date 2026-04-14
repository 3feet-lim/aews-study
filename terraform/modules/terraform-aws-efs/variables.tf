
variable "name" {
  description = "EFS의 이름"
  type        = string
}

variable "availability_zone_name" {
  description = "EFS 단일존 사용시 AZ 명 지정"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "EFS의 Subnet Id 목록"
  type        = list(string)
}

variable "security_groups" {
  description = "EFS의 보안 그룹 목록"
  type        = list(string)
}


variable "tags" {
  description = "EFS 태그"
  type        = map(string)
  default     = null
}


variable "encrypted" {
  description = "EFS 암호화 여부"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "EFS 암호화 키 설정"
  type        = string
  default     = null
}


variable "replication_overwrite" {
  description = "EFS 복제 덥어쓰기 활성화 여부"
  type        = string
  default     = null
}

variable "throughput_mode" {
  description = "EFS 처리량 모드 설정"
  type        = string
  default     = null
}

variable "performance_mode" {
  description = "EFS 성능 모드 설정"
  type        = string
  default     = null
}

variable "provisioned_throughput_in_mibps" {
  description = "EFS 프로비전 처리량 (MiB/s)"
  type        = string
  default     = null
}

variable "automatic_backup_status" {
  description = "EFS 자동 백업 상태 여부"
  type        = string
  default     = null
}

variable "transition_to_ia" {
  description = "EFS IA 전환 스케줄 설정"
  type        = string
  default     = null
}

variable "transition_to_archive" {
  description = "EFS Archive 스케줄 일정"
  type        = string
  default     = null
}

variable "transition_to_primary_storage_class" {
  description = "EFS Standard Clas 전환 정책"
  type        = string
  default     = null
}

variable "access_point" {
  description = "EFS  Access Point 목록"
  type = list(object({
    name        = optional(string)
    path        = optional(string)
    owner_uid   = optional(string)
    owner_gid   = optional(string)
    permissions = optional(string)
  }))
  default = null
}
