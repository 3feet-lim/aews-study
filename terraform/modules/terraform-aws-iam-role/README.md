# Module : IAM Role

## Overview
AWS IAM role을 생성 / 관리하기 위한 Terraform 모듈입니다.

## Features
- 신뢰정책은 data 블록을 통해 불러와서 사용(권장)

## Usage
### EKS 클러스터 역할 생성
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/iam-role/aws"
  version = "1.0.2"

  name = "test-role"
  assume_role_policy = data.aws_iam_policy_document.eks_trusted_policy.json
  iam_managed_policies = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess",
    "arn:aws:iam::255036259887:policy/pea-hrd-dev-firehose-put-policy"
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
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | 역할권한 Trusted Policy | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | 역할권한 이름 | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | 역할권한 설명 | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | policy ARNs 목록 | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | IAM Role ARN |
| <a name="output_role"></a> [role](#output\_role) | n/a |
<!-- END_TF_DOCS -->
