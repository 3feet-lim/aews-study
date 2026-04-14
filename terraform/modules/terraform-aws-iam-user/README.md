# Module : IAM User

## Overview
AWS IAM User를 생성 / 관리하기 위한 Terraform 모듈입니다.

## Features
- 

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/iam-user/aws"
  version = "1.0.2"

  name = "smlim"
  groups = []
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
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | IAM user name | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Force destroy user even if it has keys or logins | `bool` | `false` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | List of IAM group names to add this user to | `list(string)` | `[]` | no |
| <a name="input_path"></a> [path](#input\_path) | Path for the IAM user | `string` | `"/"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | IAM user ARN |
| <a name="output_name"></a> [name](#output\_name) | IAM user name |
<!-- END_TF_DOCS -->