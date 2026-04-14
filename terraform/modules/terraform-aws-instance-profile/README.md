# Module : Instance Profile

## Overview
Instance profile 을 생성 / 관리하기 위한 Terraform 모듈입니다.

## Features

## Usage
### S3 Full Access 권한 부여
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/instance-profile/aws"
  version = "1.0.3" # Latest Version 확인

  name = "test-role"
  description = "test iam-role for instance profile"

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
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
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | iam role, Instance Profile 이름 | `string` | n/a | yes |
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | ec2 profile truested policy | `string` | `"{\r\n  \"Version\": \"2012-10-17\",\r\n  \"Statement\": [\r\n    {\r\n      \"Effect\": \"Allow\",\r\n      \"Principal\": {\r\n        \"Service\": \"ec2.amazonaws.com\"\r\n      },\r\n      \"Action\": \"sts:AssumeRole\"\r\n    }\r\n  ]\r\n}\r\n"` | no |
| <a name="input_description"></a> [description](#input\_description) | iam role 에 대한 설명 | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | policy ARNs 목록 | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Instance Profile에 연결된 IAM Role ARN |
| <a name="output_instance-profile"></a> [instance-profile](#output\_instance-profile) | n/a |
| <a name="output_instance_profile_name"></a> [instance\_profile\_name](#output\_instance\_profile\_name) | Instance Profile 이름 |
| <a name="output_role"></a> [role](#output\_role) | n/a |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Instance Profile에 연결된 IAM Role 이름 |
<!-- END_TF_DOCS -->