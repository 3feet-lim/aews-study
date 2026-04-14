# Module : NLB

## Overview
NLB를 생성/관리하기 위한 Terraform 모듈입니다.

## Features
- 고정 IP 지정이 필요한 경우 `subnets` 대신 `subnet_mappings` 변수 사용
- Listeners에 target group arn이 필요한 경우 target group을 먼저 생성해주세요.
- 삭제 방지 기본 활성화
- Cross zone Load balancing 기본 활성화

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/nlb/aws"
  version = "1.0.2"

  name = "test-network-lb"
  subnets = [ "subnet-1234", "subnet-5678" ]
  listeners = [
    { port = 443, protocol = "TCP", "target_group_arn" = module.kb0_test_dev_test_tg.arn}
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
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_iam_policy_document.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_listeners"></a> [listeners](#input\_listeners) | Listener 목록 | <pre>list(object({<br/>    port             = number<br/>    protocol         = string<br/>    target_group_arn = optional(string)<br/>    ssl_policy       = optional(string)<br/>    certificate_arn  = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | NLB 이름 | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | LB가 배치될 Subnet ID 목록 | `list(string)` | n/a | yes |
| <a name="input_access_log_enabled"></a> [access\_log\_enabled](#input\_access\_log\_enabled) | Access Log 기능 활성화 여부 | `bool` | `true` | no |
| <a name="input_access_log_prefix"></a> [access\_log\_prefix](#input\_access\_log\_prefix) | Access Log를 저장할 S3 경로에 적용되는 Prefix | `string` | `null` | no |
| <a name="input_dns_record_client_routing_policy"></a> [dns\_record\_client\_routing\_policy](#input\_dns\_record\_client\_routing\_policy) | DNS 레코드 라우팅 정책 지정 | `string` | `null` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | Cross-Zone Load Balancing 기능 활성화 여부 | `bool` | `true` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | NLB 삭제 방지 기능 활성화 여부 | `bool` | `true` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | `true = internal` or `false = internet-facing` | `bool` | `true` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | NLB가 사용할 IP 주소타입 `ipv4` or `dualstack` | `string` | `"ipv4"` | no |
| <a name="input_secondary_certificate"></a> [secondary\_certificate](#input\_secondary\_certificate) | TLS 리스터 사용 시 등록할 추가 인증서 목록 | <pre>list(object({<br/>    port     = optional(number, null)<br/>    protocol = optional(string, null)<br/>    cert     = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | NLB가 구성방식에 따라 적용할 보안 그룹 목록 | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | NLB에 적용될 태그 | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | NLB ARN |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | NLB DNS 이름(Route53 alias 설정 시 사용) |
<!-- END_TF_DOCS -->
