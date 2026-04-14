variable "layer_name" {
  description = "Lambda Layer 이름"
  type        = string
}

variable "compatible_runtimes" {
  description = "Lambda Layer Runtimes 환경"
  type        = list(string)
}

variable "compatible_architectures" {
  description = "Lambda Layer 호환 아키텍처 타입"
  type        = string
  default     = "x86_64"
}

variable "license_info" {
  description = "Lambda Layer 라이센스 정보"
  type        = string
  default     = null
}

variable "filename" {
  description = "Lambda Layer 파일 이름/경로"
  type        = string
  default     = null
}

variable "s3_bucket" {
  description = "Lambda Layer S3 파일 버킷이름"
  type        = string
  default     = null
}

variable "s3_key" {
  description = "Lambda Layer S3 파일  Key 값"
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "Lambda Layer S3 파일의 버전 정보"
  type        = string
  default     = null

}

variable "skip_destroy" {
  description = "Lambda Layer 이전 버전 유지여부"
  type        = bool
  default     = false
}




