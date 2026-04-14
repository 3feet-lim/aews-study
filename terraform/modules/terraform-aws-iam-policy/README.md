# Module : IAM Policy

## Overview
AWS IAM Policy를 생성 / 관리하기 위한 Terraform 모듈입니다.

## Features
- data 블록을 활용하여 policy 정책 설정(권장)

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/iam-policy/aws"
  version = "1.0.2" # Latest version 확인

  name = "test-policy"
  description = "test policy for test role"
  path = "/"
  policy = data.aws_iam_policy_document.eks_manager_policy.json
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
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | 정책 이름 | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | 정책 설명 | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | 정책 경로 | `string` | `"/"` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | 정책 권한 | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | IAM Policy ARN |
| <a name="output_policy"></a> [policy](#output\_policy) | n/a |
<!-- END_TF_DOCS -->
