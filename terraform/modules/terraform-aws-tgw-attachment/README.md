# Module : Transit Gateway Attachment

## Overview
AWS Transit gateway attachment 를 생성 / 관리하기 위한 모듈입니다.

## Features

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/tgw-attachment/aws"
  version = "1.0.0"  # Latest version  확인

  transit_gateway_id = "tgw-1234567"
  vpc_id = "vpc-12345667"
  subnet_ids = [
    "subnet-12345687",
    "subnet-67891209"
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
| [aws_ec2_transit_gateway_vpc_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Attachment에 사용할 subnet ID 리스트 | `list(string)` | n/a | yes |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | 공유된 TGW ID | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | TGW와 연결할 VPC ID | `string` | n/a | yes |
| <a name="input_appliance_mode_support"></a> [appliance\_mode\_support](#input\_appliance\_mode\_support) | Appliance 모드 지원 활성화 여부 | `bool` | `false` | no |
| <a name="input_dns_support"></a> [dns\_support](#input\_dns\_support) | DNS 지원 활성화 여부 | `bool` | `false` | no |
| <a name="input_ipv6_support"></a> [ipv6\_support](#input\_ipv6\_support) | IPv6 지원 활성화 여부 | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | TGW Attachment 추가 할당 태그 | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | 생성된 Transit Gateway VPC Attachment의 ID |
<!-- END_TF_DOCS -->