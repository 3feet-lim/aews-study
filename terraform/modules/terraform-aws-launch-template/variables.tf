variable "lt_eks_vars" {
  description = "EKS 기본 userdata에 필요한 변수들"
  type = object({
    eks_cluster_name                  = optional(string)
    eks_cluster_endpoint              = optional(string)
    eks_cluster_certificate_authority = optional(string)
    eks_cluster_service_ipv4_cidr     = optional(string)
  })
  default = {}
}

variable "name" {
  description = "Launch Template 이름"
  type        = string
}

variable "description" {
  description = "Launch Template 설명"
  type        = string
  default     = null
}

variable "image_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 인스턴스 타입"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "VPC 보안 그룹 ID 목록"
  type        = list(string)
  default     = []
}

variable "update_default_version" {
  description = "Launch Template 업데이트 시 기본 버전으로 설정 여부"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "Userdata"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Launch Template 자체 태그"
  type        = map(string)
  default     = {}
}

variable "block_device_mappings" {
  description = "Root volume Device 매핑 설정"
  type = list(object({
    device_name           = string
    volume_size           = number
    volume_type           = string
    delete_on_termination = optional(bool, true)
    encrypted             = optional(bool, true)
    iops                  = optional(number, null)
    snapshot_id           = optional(string, null)
    kms_key_id            = optional(string, null)
  }))
  default = []
}

# Tags
variable "instance_tags" {
  description = "Instance 태그"
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "EBS Volume 태그"
  type        = map(string)
  default     = {}
}

variable "eni_tags" {
  description = "ENI 태그"
  type        = map(string)
  default     = {}
}

variable "http_put_response_hop_limit" {
  description = "http put response hot limit"
  type        = string
  default     = "2"
}

variable "http_tokens" {
  description = "Metadata 호출 시 토큰 사용 여부 `optional` 또는 `required`"
  type        = string
  default     = "required"
}

variable "http_endpoint" {
  description = "Metadata http 엔드포인트의 활성화 여부"
  type        = string
  default     = "enabled"
}

variable "instance_metadata_tags" {
  description = "Instance 태그를 메타데이터 서비스로부터 조회 가능 허용 여부"
  type        = string
  default     = "enabled"
}

variable "network_interfaces" {
  description = "launch template network interface 블럭"
  type = object({
    device_index       = optional(number, null)
    ipv4_address_count = optional(number, null)
    ipv4_addresses     = optional(list(string), null)
    ipv4_prefix_count  = optional(number, null)
    ipv4_prefixes      = optional(list(string), null)
    ipv6_address_count = optional(number, null)
    ipv6_addresses     = optional(list(string), null)
    ipv6_prefix_count  = optional(number, null)
    ipv6_prefixes      = optional(list(string), null)
    network_card_index = optional(number, null)
    security_groups    = optional(list(string), null)
  })
  default = null
}