# Module : SQS

## Overview
SQS 모듈을 생성 / 관리하기 위한 Terraform 모듈입니다. 

## Feature

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/sqs/aws"
  version = "1.0.0" # Latest version 확인

  name = "test-sqs"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sqs_queue.queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | SQS 이름 | `string` | n/a | yes |
| <a name="input_content_based_deduplication"></a> [content\_based\_deduplication](#input\_content\_based\_deduplication) | SQS 콘텐츠 기반 중복제거 활성화 여부 | `bool` | `false` | no |
| <a name="input_deduplication_scope"></a> [deduplication\_scope](#input\_deduplication\_scope) | SQS 중복 메시지 제거 범위 | `string` | `null` | no |
| <a name="input_delay_seconds"></a> [delay\_seconds](#input\_delay\_seconds) | SQS 지연 시간 | `number` | `0` | no |
| <a name="input_fifo_queue"></a> [fifo\_queue](#input\_fifo\_queue) | SQS FIFO Enabled 여부 | `bool` | `false` | no |
| <a name="input_fifo_throughput_limit"></a> [fifo\_throughput\_limit](#input\_fifo\_throughput\_limit) | SQS fifo Throughput 제한 | `string` | `null` | no |
| <a name="input_kms_data_key_reuse_period_seconds"></a> [kms\_data\_key\_reuse\_period\_seconds](#input\_kms\_data\_key\_reuse\_period\_seconds) | SQS 암호화 Key 교체 주기 | `number` | `null` | no |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | SQS 암호화 KMS ID | `string` | `null` | no |
| <a name="input_max_message_size"></a> [max\_message\_size](#input\_max\_message\_size) | SQS 메시지 최대 크기(bytes) | `number` | `1048576` | no |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | SQS 메시지 보관 기간 | `number` | `345600` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | SQS 정책 | `string` | `null` | no |
| <a name="input_receive_wait_time_seconds"></a> [receive\_wait\_time\_seconds](#input\_receive\_wait\_time\_seconds) | SQS 수신 대기 시간 | `number` | `0` | no |
| <a name="input_redrive_policy"></a> [redrive\_policy](#input\_redrive\_policy) | SQS Dead Letter Queue 정책 | `string` | `null` | no |
| <a name="input_sqs_managed_sse_enabled"></a> [sqs\_managed\_sse\_enabled](#input\_sqs\_managed\_sse\_enabled) | SQS SSE 암호화 활성화 여부 | `bool` | `true` | no |
| <a name="input_visibility_timeout_seconds"></a> [visibility\_timeout\_seconds](#input\_visibility\_timeout\_seconds) | SQS Visibility 시간 | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_queue"></a> [queue](#output\_queue) | SQS Queue 생성 정보 |
<!-- END_TF_DOCS -->