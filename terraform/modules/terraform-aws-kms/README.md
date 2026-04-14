# Module : KMS

## Overview
AWS KMS Key를 생성 및 관리하기 위한 모듈입니다.

## Features

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/kms/aws"
  version = "1.0.1"

  alias = "test-kms-key"
  description = "Customer managed key for S3"
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
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | KMS Key Alias(별칭) | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | KMS key 설명 | `string` | `"Managed by Terraform"` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | KMS Key 자동 변경 여부 | `bool` | `true` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | KMS key 정책 | `string` | `null` | no |
| <a name="input_rotation_period_in_days"></a> [rotation\_period\_in\_days](#input\_rotation\_period\_in\_days) | KMS Key 변경 주기 | `number` | `365` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | KMS key 태그 | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias_name"></a> [alias\_name](#output\_alias\_name) | The name of the KMS alias |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | The ARN of the KMS key |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | The ID of the KMS key |
<!-- END_TF_DOCS -->