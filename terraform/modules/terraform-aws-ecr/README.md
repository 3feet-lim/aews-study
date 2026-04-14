# Module : ECR

## Overview
AWS ECR repository를 생성 / 관리하기 위한 모듈입니다.

## Features

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/ecr/aws"
  version = "1.0.9"

  name = "test-ecr-repo"
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
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | ECR 리포지토리 Name | `string` | n/a | yes |
| <a name="input_create_lifecycle_policy"></a> [create\_lifecycle\_policy](#input\_create\_lifecycle\_policy) | ECR 리포지토리 lifecycle 정책 생성 여부 | `bool` | `true` | no |
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | ECR 리포지토리 암호화 방식, `AES256`, `KMS` 중에 하나 | `string` | `"AES256"` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | 리포지토리 내 image가 남아 있을 때, 강제 삭제 여부 | `bool` | `false` | no |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | ECR 리포지토리 Tag 변경 가능성 설정, `MUTABLE`, `IMMUTABLE`, `IMMUTABLE_WITH_EXCLUSION`, `MUTABLE_WITH_EXCLUSION` 중에 하나 | `string` | `"MUTABLE"` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | ECR 리포지토리 암호화에 사용할 kms key ARN | `string` | `null` | no |
| <a name="input_lifecycle_policy_json"></a> [lifecycle\_policy\_json](#input\_lifecycle\_policy\_json) | json 포맷의 ECR 리포지토리 수명주기 정책, 비어있을 시 기본값 정책 사용 | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ECR 리포지토리 Namespace | `string` | `""` | no |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | image가 리포지토리에 푸시된 후 scan을 수행할지 여부 | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | ECR 리포지토리 태그 | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->