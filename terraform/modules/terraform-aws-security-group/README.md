# Module : Security Groups

## Overview
AWS Security Group을 생성 및 관리하기 위한 모듈입니다.

## Features
- cidr_ipv4, cidr_ipv6, referenced_security_group_id, prefix_list_id, self 는 하나만 지정이 되어야 한다.

## Usage
```hcl
module <Module Name> {
  source  = "tfe.kbonecloud.com/kbonecloud/security-group/aws"
  version = "1.0.9"  # latest version 확인

  name = "test-sg"
  vpc_id = "vpc-1234abcd"
  description = "security group for test"

  ingress = [
    {from_port = 80, to_port = 80, ip_protocol = "TCP", cidr_ipv4 = "0.0.0.0/0", description = "HTTP"},
    {from_port = 443, to_port = 443, ip_protocol = "TCP", cidr_ipv4 = "0.0.0.0/0", description = "HTTPS"},
    {from_port = 443, to_port = 443, ip_protocol = "TCP", referenced_security_group_id = "sg-1234abcd", description = "for bastion"},
    {from_port = 443, to_port = 443, ip_protocol = "TCP", self = true, description = "self sg add"}
  ]
  egress = [
    {from_port = 0, to_port = 0, protocol = -1, cidr_ipv4 = "0.0.0.0/0", description = "default"} # 모든 port, protocol 개방
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
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | 보안 그룹 설명 | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | 보안 그룹 이름 | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | 보안 그룹이 배치되는 VPC ID | `string` | n/a | yes |
| <a name="input_egress"></a> [egress](#input\_egress) | Outbound 정책 목록 | <pre>list(object({<br/>    from_port                    = string<br/>    to_port                      = string<br/>    ip_protocol                  = string<br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    prefix_list_id               = optional(string)<br/>    description                  = string<br/>    self                         = optional(bool)<br/>    tags                         = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | Inbound 정책 목록 | <pre>list(object({<br/>    from_port                    = string<br/>    to_port                      = string<br/>    ip_protocol                  = string<br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    prefix_list_id               = optional(string)<br/>    description                  = string<br/>    self                         = optional(bool)<br/>    tags                         = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_revoke_rules_on_delete"></a> [revoke\_rules\_on\_delete](#input\_revoke\_rules\_on\_delete) | 보안 그룹이 삭제될 때 연결된 규칙 자동 해체 여부 | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | 보안 그룹 태그 | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | SG의 ID |
| <a name="output_sg"></a> [sg](#output\_sg) | SG의 Info |
<!-- END_TF_DOCS -->
