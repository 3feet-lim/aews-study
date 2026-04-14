# Module : Prefix List

## Overview
Prefix List 를 생성 / 관리하기 위한 Terraform 모듈입니다. 

## Feature

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/prefix-list/aws"
  version = "1.0.3"

  max_entries = 1
  name = "test-list"

  entry = [
    { cidr = "23.151.123.0/27", description="test"}
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
| [aws_ec2_managed_prefix_list.prefix_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_max_entries"></a> [max\_entries](#input\_max\_entries) | 관리형 접두사 IP 목록 최대 갯수 | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | 관리형 접두사 목록 IP 이름 | `string` | n/a | yes |
| <a name="input_entry"></a> [entry](#input\_entry) | 관리형 접두사 IP 목록 | <pre>list(object({<br/>    cidr        = string<br/>    description = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_prefix_list"></a> [prefix\_list](#output\_prefix\_list) | External Prefix IP INFO |
<!-- END_TF_DOCS -->
