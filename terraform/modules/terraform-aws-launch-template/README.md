# Module: Launch template

## Overview
KB One Cloud 내 AWS Launch Template를 생성 및 관리하기 위한 모듈 입니다.

## Feature
- EKS nodegroup용 LT를 생성할 때는 반드시 eks_lt_vars 를 넣어야 한다.

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/launch-template/aws"
  version = "1.0.3"
  
  name = "test-lt"
  image_id = "ami-12345678"
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
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | AMI ID | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Launch Template 이름 | `string` | n/a | yes |
| <a name="input_block_device_mappings"></a> [block\_device\_mappings](#input\_block\_device\_mappings) | Root volume Device 매핑 설정 | <pre>list(object({<br/>    device_name           = string<br/>    volume_size           = number<br/>    volume_type           = string<br/>    delete_on_termination = optional(bool, true)<br/>    encrypted             = optional(bool, true)<br/>    iops                  = optional(number, null)<br/>    snapshot_id           = optional(string, null)<br/>    kms_key_id            = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | Launch Template 설명 | `string` | `null` | no |
| <a name="input_eni_tags"></a> [eni\_tags](#input\_eni\_tags) | ENI 태그 | `map(string)` | `{}` | no |
| <a name="input_http_endpoint"></a> [http\_endpoint](#input\_http\_endpoint) | Metadata http 엔드포인트의 활성화 여부 | `string` | `"enabled"` | no |
| <a name="input_http_put_response_hop_limit"></a> [http\_put\_response\_hop\_limit](#input\_http\_put\_response\_hop\_limit) | http put response hot limit | `string` | `"2"` | no |
| <a name="input_http_tokens"></a> [http\_tokens](#input\_http\_tokens) | Metadata 호출 시 토큰 사용 여부 `optional` 또는 `required` | `string` | `"required"` | no |
| <a name="input_instance_metadata_tags"></a> [instance\_metadata\_tags](#input\_instance\_metadata\_tags) | Instance 태그를 메타데이터 서비스로부터 조회 가능 허용 여부 | `string` | `"enabled"` | no |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | Instance 태그 | `map(string)` | `{}` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 인스턴스 타입 | `string` | `null` | no |
| <a name="input_lt_eks_vars"></a> [lt\_eks\_vars](#input\_lt\_eks\_vars) | EKS 기본 userdata에 필요한 변수들 | <pre>object({<br/>    eks_cluster_name                  = optional(string)<br/>    eks_cluster_endpoint              = optional(string)<br/>    eks_cluster_certificate_authority = optional(string)<br/>    eks_cluster_service_ipv4_cidr     = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_network_interfaces"></a> [network\_interfaces](#input\_network\_interfaces) | launch template network interface 블럭 | <pre>object({<br/>    device_index       = optional(number, null)<br/>    ipv4_address_count = optional(number, null)<br/>    ipv4_addresses     = optional(list(string), null)<br/>    ipv4_prefix_count  = optional(number, null)<br/>    ipv4_prefixes      = optional(list(string), null)<br/>    ipv6_address_count = optional(number, null)<br/>    ipv6_addresses     = optional(list(string), null)<br/>    ipv6_prefix_count  = optional(number, null)<br/>    ipv6_prefixes      = optional(list(string), null)<br/>    network_card_index = optional(number, null)<br/>    security_groups    = optional(list(string), null)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Launch Template 자체 태그 | `map(string)` | `{}` | no |
| <a name="input_update_default_version"></a> [update\_default\_version](#input\_update\_default\_version) | Launch Template 업데이트 시 기본 버전으로 설정 여부 | `bool` | `true` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Userdata | `string` | `""` | no |
| <a name="input_volume_tags"></a> [volume\_tags](#input\_volume\_tags) | EBS Volume 태그 | `map(string)` | `{}` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | VPC 보안 그룹 ID 목록 | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_version"></a> [default\_version](#output\_default\_version) | Launch Template 기본 버전 |
| <a name="output_id"></a> [id](#output\_id) | Launch Template ID |
| <a name="output_latest_version"></a> [latest\_version](#output\_latest\_version) | Launch Template 최신 버전 |
| <a name="output_name"></a> [name](#output\_name) | Launch Template 이름 |
<!-- END_TF_DOCS -->