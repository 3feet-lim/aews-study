# ECR Info
variable "namespace" {
  description = "ECR 리포지토리 Namespace"
  type        = string
  default     = ""
}

variable "name" {
  description = "ECR 리포지토리 Name"
  type        = string
}

variable "image_tag_mutability" {
  description = "ECR 리포지토리 Tag 변경 가능성 설정, `MUTABLE`, `IMMUTABLE`, `IMMUTABLE_WITH_EXCLUSION`, `MUTABLE_WITH_EXCLUSION` 중에 하나"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "image가 리포지토리에 푸시된 후 scan을 수행할지 여부"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "ECR 리포지토리 암호화 방식, `AES256`, `KMS` 중에 하나"
  type        = string
  default     = "AES256"
}

variable "kms_key" {
  description = "ECR 리포지토리 암호화에 사용할 kms key ARN"
  type        = string
  default     = null
}

variable "force_delete" {
  description = "리포지토리 내 image가 남아 있을 때, 강제 삭제 여부"
  type        = bool
  default     = false
}

variable "create_lifecycle_policy" {
  description = "ECR 리포지토리 lifecycle 정책 생성 여부"
  type        = bool
  default     = true
}

variable "lifecycle_policy_json" {
  description = "json 포맷의 ECR 리포지토리 수명주기 정책, 비어있을 시 기본값 정책 사용"
  type        = string
  default     = null
}

variable "tags" {
  description = "ECR 리포지토리 태그"
  type        = map(string)
  default     = {}
}