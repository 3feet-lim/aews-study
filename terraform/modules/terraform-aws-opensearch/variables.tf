variable "domain_name" {
  description = "Opensearch 도메인 이름"
  type        = string
}

variable "engine_version" {
  description = "Opensearch 엔진 버전"
  type        = string
}

variable "instance_type" {
  description = "Opensearch 데이터노드 인스턴스 타입"
  type        = string
}

variable "instance_count" {
  description = "Opensearch 데이터노드 인수턴스 갯수"
  type        = number
  default     = 1
}

variable "zone_awareness_enabled" {
  description = "Opensearch Multi-AZ 활성화 여부"
  type        = bool
  default     = false
}

variable "az_count" {
  description = "Opensearch AZ 갯수"
  type        = number
  default     = 2
}

variable "ebs_enabled" {
  description = "Opensearch 데이터노드 볼륨 연결 여부"
  type        = bool
  default     = true
}

variable "volume_type" {
  description = "Opensearch 데이터노드 볼륨 타입"
  type        = string
  default     = "gp3"
}

variable "volume_size" {
  description = "Opensearch 데이터노드 볼륨 사이즈"
  type        = number
  default     = 100
}


variable "enforce_https" {
  description = "Opensearch 도메인 HTTPS 연결 여부"
  type        = bool
  default     = true
}

variable "node_to_node_encryption" {
  description = "Opensearch 노드간 보안 연결 여부"
  type        = bool
  default     = true
}


variable "encrypt_at_rest" {
  description = "Opensearch 도메인 보안 호출 여부"
  type        = bool
  default     = true
}

variable "tls_security_policy" {
  description = "Opensearch TLS 정책"
  type        = string
  default     = "Policy-Min-TLS-1-2-2019-07"
}

variable "iops" {
  description = "Opensearch 데이터노드 볼륨 IOPS"
  type        = number
  default     = null
}

variable "throughput" {
  description = "Opensearch 데이터노드 볼륨 IOPS(throughput in MB/s (gp3 only))"
  type        = number
  default     = null
}

variable "master_enabled" {
  description = "Opensearch 마스터노드 별도 구성 여부"
  type        = bool
  default     = false
}

variable "warm_enabled" {
  description = "Opensearch Warm 노드 활성 화 여부"
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "Opensearch Subnet ID"
  type        = string
}

variable "security_group_ids" {
  description = "Opensearch 보안 그릅 ID"
  type        = list(string)
  default     = []
}

variable "fgac_enabled" {
  description = "Opensearch fine-grained access control (FGAC) 활성화 여부"
  type        = bool
  default     = true
}

variable "master_user_name" {
  description = "Opensearch FGAC 마스터사용자 이름"
  type        = string
  default     = null
}

variable "master_user_password" {
  description = "Opensearch FGAC 마스터사용자 비밀번호"
  type        = string
  default     = null
  sensitive   = true
}

variable "master_user_arn" {
  description = "Opensearch FGAC 마스터사용자 역할권한"
  type        = string
  default     = null
}

variable "anonymous_auth_enabled" {
  description = "Opensearch 익명 접근 허용 여부"
  type        = bool
  default     = false
}

variable "access_policies" {
  description = "Opensearch Access policy"
  type        = string
  default     = null
}
