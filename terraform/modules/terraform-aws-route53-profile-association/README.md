# Module : Route53 Profile Association

## Overview
AWS Route53 Profile Association을 생성 / 관리하기 위한 모듈입니다. 

## Features

## Usage
```hcl
module <module_name> {
  source = 
  version = "~> 1.0"  # Latest patch version
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
| [aws_route53profiles_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53profiles_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Route53 Profile Association 이름 | `string` | n/a | yes |
| <a name="input_profile_id"></a> [profile\_id](#input\_profile\_id) | Route53 Profile Association Profile ID | `string` | n/a | yes |
| <a name="input_resource_id"></a> [resource\_id](#input\_resource\_id) | Route53 Profile Association 대상 리소스 ID | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Route53 Profile Association Tags | `map(string)` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->