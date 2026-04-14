variable "function_name" {
  description = "Lambda Function의 이름"
  type        = string
}

variable "description" {
  description = "Lambda Function의 설명"
  type        = string
  default     = null
}

variable "filename" {
  description = "Lambda Function의 소스 파일 경로/이름"
  type        = string
  default     = null
}

variable "s3_bucket" {
  description = "Lambda Function의 S3 소스 파일 버킷"
  type        = string
  default     = null
}

variable "s3_key" {
  description = "Lambda Function의 S3 소스 파일 Key"
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "Lambda Function의 S3 소스 파일 버전"
  type        = string
  default     = null
}

variable "role" {
  description = "Lambda Function의 역할 권한"
  type        = string
}

variable "handler" {
  description = "Lambda Function의 실행 핸들러 지정"
  type        = string
}

variable "runtime" {
  description = "Lambda Function의 실행 환경"
  type        = string
}

variable "architectures" {
  description = "Lambda Function의 실행 아키텍처"
  type        = list(string)
  default     = ["x86_64"]
}

variable "layers" {
  description = "Lambda Function의 실행 환경 참조 Layer"
  type        = list(string)
  default     = null
}

variable "memory_size" {
  description = "Lambda Function의 메모리 리소스 사이즈"
  type        = number
  default     = 128
}
variable "timeout" {
  description = "Lambda Function의 실행 타입아웃 지정"
  type        = number
  default     = 3
}
variable "package_type" {
  description = "Lambda Function의 Package 타입"
  type        = string
  default     = "Zip"
}

variable "publish" {
  description = "Lambda Function의 생성/수정후 배포 여부"
  type        = bool
  default     = false
}

variable "reserved_concurrent_executions" {
  description = "Lambda Function의 동시 실행 갯수 제한"
  type        = number
  default     = -1
}

variable "skip_destroy" {
  description = "Lambda Function의 신규 Layer 유지 여부"
  type        = bool
  default     = false
}

variable "variables" {
  description = "Lambda Function의 환경 변수"
  type        = map(string)
  default     = null
}

variable "security_group_ids" {
  description = "Lambda Function의 보안 그룹 ID"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Lambda Function의 서브넷 ID"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Lambda Function의 태그"
  type        = map(string)
  default     = null
}

variable "source_code_hash" {
  description = "Lambda Function소스코드 Hash 값"
  type        = string
}