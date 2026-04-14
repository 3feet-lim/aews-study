variable "name" {
  description = "Instance의 이름"
  type        = string
}

variable "ami" {
  description = "Instance의 AMI ID"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Instance의 보안 그룹 ID 목록"
  type        = list(string)
}

variable "key_name" {
  description = "Instance의 SSH KEY"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "Instance의 타입"
  type        = string
}

variable "subnet_id" {
  description = "Instance가 배치되는 Subnet ID"
  type        = string
}

variable "volume_size" {
  description = "Instance의 Root 볼륨 사이즈"
  type        = number
  default     = null
}

variable "volume_type" {
  description = "Instancedml Root 볼륨 타입"
  type        = string
  default     = "gp3"
}

variable "encrypted" {
  description = "Instance의 Root 볼륨 암호화 여부"
  type        = string
  default     = "true"
}

variable "user_data" {
  description = "Instance의 User-Data"
  type        = string
  default     = null
}

variable "launch_template" {
  description = "Launch Template 정보"
  type = object({
    id = string
    version = optional(string)
  })
  default = null
}

variable "iam_instance_profile" {
  description = "Instance의 인스턴스 프로파일"
  type        = string
  default     = null
}

variable "ipv6_address_count" {
  description = "Instance의 IPv6이 주소 갯수"
  type        = number
  default     = null
}

variable "delete_on_termination" {
  description = "Instance 삭제시 Root 볼륨 삭제 여부"
  type        = string
  default     = "true"
}

variable "disable_api_termination" {
  description = "Instance의 삭제 보호 여부"
  type        = string
  default     = "true"
}

variable "private_ip" {
  description = "Instance의 Private IP 주소"
  type        = string
  default     = null
}

variable "source_dest_check" {
  description = "Instance의 ENI의 출발지/목적지 체크 설정 옵션"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags for EC2"
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "Tags for EC2 Volume"
  type        = map(string)
  default     = {}
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

variable "http_put_response_hop_limit" {
  description = "HTTP PUT response hop limit"
  type        = number
  default     = 2
}