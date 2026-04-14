variable "name" {
  description = "SQS 이름"
  type        = string
}

variable "fifo_queue" {
  description = "SQS FIFO Enabled 여부"
  type        = bool
  default     = false
}

# Configuration
variable "delay_seconds" {
  description = "SQS 지연 시간"
  type        = number
  default     = 0
}
variable "max_message_size" {
  description = "SQS 메시지 최대 크기(bytes)"
  type        = number
  default     = 1048576
}
variable "message_retention_seconds" {
  description = "SQS 메시지 보관 기간"
  type        = number
  default     = 345600
}
variable "receive_wait_time_seconds" {
  description = "SQS 수신 대기 시간"
  type        = number
  default     = 0
}
variable "visibility_timeout_seconds" {
  description = "SQS Visibility 시간"
  type        = number
  default     = 30
}

# fifO
variable "content_based_deduplication" {
  description = "SQS 콘텐츠 기반 중복제거 활성화 여부"
  type        = bool
  default     = false
}
variable "deduplication_scope" {
  description = "SQS 중복 메시지 제거 범위"
  type        = string
  default     = null # messageGroup, queue
}
variable "fifo_throughput_limit" {
  description = "SQS fifo Throughput 제한"
  type        = string
  default     = null # perQueue, perMessageGroupId
}

# DLQ
variable "redrive_policy" {
  description = "SQS Dead Letter Queue 정책"
  type        = string
  default     = null
}

# 암호화
variable "kms_master_key_id" {
  description = "SQS 암호화 KMS ID"
  type        = string
  default     = null
}
variable "kms_data_key_reuse_period_seconds" {
  description = "SQS 암호화 Key 교체 주기"
  type        = number
  default     = null
}
variable "sqs_managed_sse_enabled" {
  description = "SQS SSE 암호화 활성화 여부"
  type        = bool
  default     = true
}

# 정책
variable "policy" {
  description = "SQS 정책"
  type        = string
  default     = null
}