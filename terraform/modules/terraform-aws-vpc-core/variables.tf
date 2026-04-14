# VPC NAME
variable "name" {
  description = "VPC의 이름"
  type        = string
}

# VPC Premiry IP CIDR
variable "cidr_block" {
  description = "VPC의 CIDR 대역"
  type        = string
}

# VPC Secondary IP CIDR
variable "secondary_cidr_block" {
  description = "VPC의 추가 CIDR 대역"
  type        = list(string)
  default     = null
}

# Internet Gateway Enable 여부
variable "igw_enable" {
  description = "Internet Gateway 생성 여부"
  type        = bool
  default     = false
}

# Internet Gateway Name
variable "igw_name" {
  description = "Ingernet Gateway 이름"
  type        = string
  default     = ""
}

# VPC FLOWLOG Enable 여부
variable "vpc_flowlog_enable" {
  description = "VPC FlowLog 활성화 여부"
  type        = bool
  default     = true
}

# VPC FLOWLOG Name
variable "vpc_flowlog_name" {
  description = "VPC FlowLog 이름"
  type        = string
  default     = ""
}

# VPC FLOWLOG Filter
variable "traffic_type" {
  description = "VPC FlowLog 수집 대상 필터(Accept/Reject)"
  type        = string
  default     = "ALL"
}

# VPC FLOWLOG 수집주기
variable "max_aggregation_interval" {
  description = "VPC FlowLog의 수집 주기"
  type        = number
  default     = 60
}

# VPC FLOWLOG 로그 포맷
variable "log_format" {
  description = "VPC FlowLog의 수집 형태(Format)"
  type        = string
  default     = "$${version} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status} $${tcp-flags} $${pkt-srcaddr} $${pkt-dstaddr} $${flow-direction}"
}

# VPC FLOWLOG Role Name
variable "vpc_flowlog_role_name" {
  description = "VPC FlowLog의 역할권한 이름"
  type        = string
  default     = ""
}

# VPC FLOWLOG Policy Name
variable "vpc_flowlog_policy_name" {
  description = "VPC FlowLog의 역할권한의 정책 이름"
  type        = string
  default     = ""
}

# VPC FLOWLOG 저장소 타입
variable "log_destination_type" {
  description = "VPC FlowLog 목적지"
  type        = string
  default     = "s3"
}

# VPC FLOWLOG 저장소 명
variable "vpc_flowlog_bucket_name" {
  description = "VPC FlowLog의 저장소 S3 버킷 이름"
  type        = string
  default     = ""
}

# VPC FLOWLOG 저장소 versioning
variable "vpc_flowlog_bucket_versioning" {
  description = "VPC FlowLog의 저장소 S3의 버저닝 옵션 설정"
  type = string
  default	= "Enabled"
}

variable "tags" {
  description = "VPC 태그"
  type        = map(string)
  default     = {}
}