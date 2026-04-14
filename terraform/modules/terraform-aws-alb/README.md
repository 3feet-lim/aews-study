# Module : ALB

## Overview
ALB 모듈을 생성 / 관리하기 위한 Terraform 모듈입니다. 

## Features
- listeners 중 forward 또는 redirect 만 입력
- Access Log는 기본 활성화 (필요시 `access_log_enabled = false`)

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/alb/aws"
  version = "1.0.3" # Latest version 확인

  name = "service-code-env-cluster-alb"
  subnets = ["subnet-12345678", "subnet-56780987"]
  listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = ""
      certificate_arn = "arn:aws:acm:ap-northeast-2:000000000:certificate/55684321-984asdf-asdf985"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        path        = "/app/#{path}"
        status_code = "HTTP_302"
      }
    }
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_listeners"></a> [listeners](#input\_listeners) | ALB에 생성할 리스터의 설정 목록 | <pre>list(object({<br/>    port                  = number<br/>    protocol              = string<br/>    ssl_policy            = optional(string)<br/>    certificate_arn       = optional(string)<br/>    secondary_certificate = optional(string)<br/>    order                 = optional(string)<br/>    forward = optional(object({<br/>      target_group_arn = optional(string)<br/>    }))<br/>    redirect = optional(object({<br/>      host        = optional(string)<br/>      path        = optional(string)<br/>      port        = optional(string)<br/>      protocol    = optional(string)<br/>      query       = optional(string)<br/>      status_code = string<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ALB 이름 | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | LB가 배치될 Subnet ID 목록 | `list(string)` | n/a | yes |
| <a name="input_access_log_bucket_name"></a> [access\_log\_bucket\_name](#input\_access\_log\_bucket\_name) | ALB Access log 버킷 이름 | `string` | `null` | no |
| <a name="input_access_log_enabled"></a> [access\_log\_enabled](#input\_access\_log\_enabled) | ALB Access log 활성화 여부 | `bool` | `true` | no |
| <a name="input_access_log_prefix"></a> [access\_log\_prefix](#input\_access\_log\_prefix) | ALB Access log bucket prefix | `string` | `""` | no |
| <a name="input_drop_invalid_header_fields"></a> [drop\_invalid\_header\_fields](#input\_drop\_invalid\_header\_fields) | ALB가 잘못된 형식의 HTTP 헤더를 감지했을 때 자동 제거 여부 | `bool` | `false` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | Cross-Zone Load Balancing 기능 활성화 여부 | `bool` | `true` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | ALB 삭제 방지 기능 활성화 여부 | `bool` | `false` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | ALB에서 http/2 프로토콜 지원 활성화 여부 | `bool` | `true` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | ALB 연결이 유휴 상태로 유지될 때 최대 시간(초) | `number` | `60` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | `internal` or `internet-facing` | `bool` | `false` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | ALB가 사용할 IP 주소 유형 (ipv4 or dualstack). | `string` | `"ipv4"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | ALB에 연결할 Security Group ID 목록 | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | ALB에 부여할 태그 | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
