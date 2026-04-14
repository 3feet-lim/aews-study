# Module : S3

## Overview
S3 버킷을 생성 / 관리하는 Terraform 모듈입니다.

## Features
- versioning 기본 비활성화
- public Access 차단 기본 활성화
- encryption 기본 활성화 (kms key 추가 시 kms 키 암호화 자동 설정)

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/s3/aws"
  version = "1.0.6" # Latest version 확인

  bucket = "test-bucket"
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
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | S3 버킷 이름 | `string` | n/a | yes |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | S3 버킷 및 객체에 퍼블릭 ACL 접근 차단 여부 | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | 퍼블릭 액세스를 허용하는 버킷 정책 적용 차단 여부 | `bool` | `true` | no |
| <a name="input_bucket_key_enabled"></a> [bucket\_key\_enabled](#input\_bucket\_key\_enabled) | SSE-KMS 사용 시 S3 Bucket key 기능 활성화 여부 | `bool` | `true` | no |
| <a name="input_enable_encryption"></a> [enable\_encryption](#input\_enable\_encryption) | server-side 암호화 여부 | `bool` | `true` | no |
| <a name="input_enable_public_access_block"></a> [enable\_public\_access\_block](#input\_enable\_public\_access\_block) | Public 접근 제한 여부 | `bool` | `true` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | S3 버킷 Versioning 기능 사용 여부 | `bool` | `false` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | 버킷 삭제 시 Object 강제 삭제 여부 | `bool` | `false` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | 퍼블릭 ACL이 설정된 객체를 무시하고 접근 제한 여부 | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | S3 bucket 암호화에 사용할 KMS 키 식별자 (Key ID, ARN, Alias 이름, Alias ARN 중 하나) | `string` | `null` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | 수명주기 정책 | <pre>list(object({<br/>    id      = string<br/>    enabled = bool<br/>    prefix  = optional(string)<br/>    transition = optional(object({<br/>      days          = number<br/>      storage_class = string<br/>    }))<br/>    expiration = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | 퍼블릭 액세스가 있는 버킷에 대한 요청 제한 여부 | `bool` | `true` | no |
| <a name="input_rotation_period_in_days"></a> [rotation\_period\_in\_days](#input\_rotation\_period\_in\_days) | S3 kms key 변경 주기 | `number` | `365` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | S3 버킷 Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the S3 bucket |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The ID of the S3 bucket |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the S3 bucket |
<!-- END_TF_DOCS -->
