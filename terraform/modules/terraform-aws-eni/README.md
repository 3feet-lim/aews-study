# Module: ENI
AWS ENI 를 수동 생성 / 관리하기 위한 모듈입니다.

## Features
#인터페이스 타입 ("ENA", "EFA with ENA", "EFA-only")
- Interface type은 `ena` `efa`, `default = "ena"`

## Usage
```hcl
module <module_name> {
  source = 
  version = "~> 1.0"

  enis = {
    eni-1 = { 
      subnet_id = "subnet-123456" 
    }
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
| [aws_network_interface.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enis"></a> [enis](#input\_enis) | 생성하게 되는  ENI를 정의하는 map | <pre>map(object({<br/>    description                = optional(string, null)<br/>    subnet_id                  = string<br/>    security_group_ids         = optional(list(string), [])<br/>    private_ip                 = optional(string, null)<br/>    secondary_private_ips      = optional(list(string), [])<br/>    secondary_private_ip_count = optional(number, null)<br/>    ipv6_address_count         = optional(number, 0)<br/>    ipv6_addresses             = optional(list(string), [])<br/>    source_dest_check          = optional(bool, true)<br/>    interface_type             = optional(string, null)<br/>    attachment = optional(object({<br/>      instance_id           = string<br/>      device_index          = number<br/>      delete_on_termination = optional(bool, true)<br/>    }))<br/>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eni_all_private_ips"></a> [eni\_all\_private\_ips](#output\_eni\_all\_private\_ips) | 각 ENI의 모든 private IP 목록 |
| <a name="output_eni_ids"></a> [eni\_ids](#output\_eni\_ids) | 생성된 ENI ID |
| <a name="output_eni_primary_private_ips"></a> [eni\_primary\_private\_ips](#output\_eni\_primary\_private\_ips) | 각 ENI의 기본 private IP |
<!-- END_TF_DOCS -->
