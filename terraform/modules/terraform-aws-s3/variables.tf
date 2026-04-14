variable "bucket" {
  description = "S3 버킷 이름"
  type        = string
}

variable "force_destroy" {
  description = "버킷 삭제 시 Object 강제 삭제 여부"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "S3 버킷 Versioning 기능 사용 여부"
  type        = bool
  default     = false
}

variable "enable_encryption" {
  description = "server-side 암호화 여부"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "S3 bucket 암호화에 사용할 KMS 키 식별자 (Key ID, ARN, Alias 이름, Alias ARN 중 하나)"
  type        = string
  default     = null
}

variable "rotation_period_in_days" {
  description = "S3 kms key 변경 주기"
  type        = number
  default     = 365
}

variable "bucket_key_enabled" {
  description = "SSE-KMS 사용 시 S3 Bucket key 기능 활성화 여부"
  type        = bool
  default     = true
}

variable "enable_public_access_block" {
  description = "Public 접근 제한 여부"
  type        = bool
  default     = true
}

variable "block_public_acls" {
  description = "S3 버킷 및 객체에 퍼블릭 ACL 접근 차단 여부"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "퍼블릭 액세스를 허용하는 버킷 정책 적용 차단 여부"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "퍼블릭 ACL이 설정된 객체를 무시하고 접근 제한 여부"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "퍼블릭 액세스가 있는 버킷에 대한 요청 제한 여부"
  type        = bool
  default     = true
}

variable "tags" {
  description = "S3 버킷 Tags"
  type        = map(string)
  default     = {}
}

variable "lifecycle_rules" {
  description = "수명주기 정책"
  type = list(object({
    id      = string
    enabled = bool
    prefix  = optional(string)
    transition = optional(object({
      days          = number
      storage_class = string
    }))
    expiration = optional(number)
    abort_incomplete_multipart_upload_days = optional(number)
  }))
  default = []
}

variable "policy" {
  description = "S3 버킷의 정책"
  type        = string
  default     = null
}