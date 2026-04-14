# Module : Route-Table

## Overview
AWS VPC Route-Table 을 생성 / 관리하기 위한 Terraform 모듈입니다.

## Features

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/route-table/aws"
  version = "1.0.7"

  name = "test-rt"
  vpc_id = "vpc-1234abcd"

  routes = [
    { cidr_block = "0.0.0.0/0", gateway_id = "igw-1234abcd" },          # igw
    { cidr_block = "0.0.0.0/0", nat_gateway_id = "nat-1234abcd" },      # nat
    { cidr_block = "0.0.0.0/0", transit_gateway_id = "tgw-1234abcd" },  # tgw
    { cidr_block = "0.0.0.0/0", vpc_endpoint_id = "vpce-1234abcd" },    # vpce
  ]

  subnet_ids = [
    "subnet-1234abcd",
    "subnet-5678efgh"
  ]

  tags = {
    Env = "dev"
    Servicegroup = "pea"
  }
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
| [aws_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Route Table 이름 | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc ID | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | 라우팅 정보 | <pre>list(object({<br/>    destination_cidr_block     = optional(string)<br/>    destination_prefix_list_id = optional(string)<br/>    gateway_id                 = optional(string)<br/>    nat_gateway_id             = optional(string)<br/>    network_interface_id       = optional(string)<br/>    transit_gateway_id         = optional(string)<br/>    vpc_endpoint_id            = optional(string)<br/>    vpc_peering_connection_id  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Route Table 연결할 subnet id | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Route Table 태그 | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Route Table ARN |
| <a name="output_id"></a> [id](#output\_id) | Route Table ID |
<!-- END_TF_DOCS -->
