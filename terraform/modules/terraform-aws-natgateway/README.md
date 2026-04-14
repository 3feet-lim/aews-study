# Module : NAT Gateway

## Overview
KB One Cloud 내 AWS **NAT Gateway** 를 생성 및 관리하는 모듈 입니다.

## Features
- private NAT gateway 가 기본 옵션

## Usage
### Private NAT Gateway
```hcl
module "<Module Name>" {
  source  = "tfe.kbonecloud.com/kbonecloud/natgateway/aws"
  version = "1.0.5"

  natgateway = [
    { name = "test-nat-gateway", subnet_id = "subnet-1234abcd"}
  ]

  tags = {
    Env = "dev"
    ...
  }
}
```

### Public NAT gateway
```hcl
module "<Module Name>" {
  source  = "tfe.kbonecloud.com/kbonecloud/natgateway/aws"
  version = "1.0.5"

  natgateway = [
    { name = "test-nat-gateway", subnet_id = "subnet-1234abcd", connectivity_type = "public"}
  ]

  tags = {
    Env = "dev"
    ...
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
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_nat_gateway.natgateways](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eip_tags"></a> [eip\_tags](#input\_eip\_tags) | EIP 태그 | `map(string)` | `{}` | no |
| <a name="input_natgateway"></a> [natgateway](#input\_natgateway) | Nat Gateway 설정 목록 | <pre>list(object({<br/>    name              = string<br/>    subnet_id         = string<br/>    connectivity_type = optional(string, "private")<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Nat Gateway 태그 | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_natgateways"></a> [natgateways](#output\_natgateways) | NAT GW INFO |
<!-- END_TF_DOCS -->
