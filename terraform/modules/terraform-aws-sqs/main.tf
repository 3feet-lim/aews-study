####################################################################
# Module Name : SQS
# Module Desc : SQS 생성
####################################################################

####################################################################
# SQS 생성
resource "aws_sqs_queue" "queue" {

  name       = var.fifo_queue ? "${var.name}.fifo" : var.name
  fifo_queue = var.fifo_queue

  # Configuration
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds

  # fifO
  content_based_deduplication = var.content_based_deduplication
  deduplication_scope         = var.deduplication_scope
  fifo_throughput_limit       = var.fifo_throughput_limit

  # DLQ
  redrive_policy = var.redrive_policy

  # 암호화
  kms_master_key_id                 = var.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  sqs_managed_sse_enabled           = var.sqs_managed_sse_enabled

  # 정책
  policy = var.policy

} 
