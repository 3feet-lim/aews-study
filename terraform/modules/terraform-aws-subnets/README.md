# Module : Subnets

## Overview
KB One Cloud 내 VPC Subnets를 생성 및 관리하기 위한 모듈입니다.

## 주요기능
- public IP는 기본적으로 비활성화

## Usage
```hcl
module <Module Name> {
  source  = "tfe.kbonecloud.com/kbonecloud/subnets/aws"
  version = "1.0.5"

  vpc_id = "vpc-1234abcd"
  subnets = [
    { name = "subnet-name1", availability_zone_id = "", cidr_block = "100.70.0.0/26"}
    { name = "subnet-name2", availability_zone_id = "", cidr_block = "100.70.0.128/26"}
    { name = "subnet-name3", availability_zone_id = "", cidr_block = "100.70.0.192/26"}
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
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | 서브넷이 배치되는 VPC ID | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | 서브넷 설정 목록 | <pre>list(object({<br/>    name                    = string<br/>    availability_zone_id    = string<br/>    cidr_block              = string<br/>    map_public_ip_on_launch = optional(bool, false)<br/>    tags                    = optional(map(string))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnets"></a> [subnets](#output\_subnets) | SUBNET INFO |
<!-- END_TF_DOCS -->
