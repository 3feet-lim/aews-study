# Module : NLB Target Group

## Overview
AWS NLB 전용 Target Group을 생성 / 관리하기 위한 모듈입니다.

## Features
- target group type 기본값은 `instance`

## Usage
### instance
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/tg-nlb/aws"
  version = "1.0.2"

  name = "test-nlb-tg"
  port = 80
  targets = [
    { id = "i-abcd1234", port = 80 }
  ]
}
```

### alb
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/tg-nlb/aws"
  version = "1.0.2"

  name = "test-nlb-tg"
  port = 80
  target_type = "alb"
  targets = [
    { id = "alb-abcd1234", port = 80 }
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
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Target group 이름 | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | Target group이 수신할 port | `number` | n/a | yes |
| <a name="input_targets"></a> [targets](#input\_targets) | Target group에 등록할 대상 리스트 | <pre>list(object({<br/>    id   = string<br/>    port = optional(number)<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Target group이 속한 VPC ID | `string` | n/a | yes |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | Target group에서 대상이 등록 해제된 후 연결을 완전히 종료하기 전까지 대기하는 시간(초) | `number` | `300` | no |
| <a name="input_health_check_enabled"></a> [health\_check\_enabled](#input\_health\_check\_enabled) | Health check 활성화 여부 | `bool` | `true` | no |
| <a name="input_health_check_healthy_threshold"></a> [health\_check\_healthy\_threshold](#input\_health\_check\_healthy\_threshold) | Health check 성공으로 간주하기 위한 연속 성공 횟수 | `number` | `3` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | Health check 수행 간격 | `number` | `30` | no |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | Health check 성공으로 간주할 응답 코드 | `string` | `null` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Health check 요청 경로 | `string` | `null` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | Health check 시 사용하는 프로토콜 | `string` | `"TCP"` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | Health check 요청 후 응답을 기다리는 최대 시간(초) | `number` | `5` | no |
| <a name="input_health_check_unhealthy_threshold"></a> [health\_check\_unhealthy\_threshold](#input\_health\_check\_unhealthy\_threshold) | Health check 실패로 간주하기 위한 연속 실패 횟수 | `number` | `3` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | 통신 protocol (TCP, TLS, UDP, TCP\_UDP) | `string` | `"TCP"` | no |
| <a name="input_proxy_protocol_v2"></a> [proxy\_protocol\_v2](#input\_proxy\_protocol\_v2) | NLB(TCP/TLS)용 Proxy protocol v2 활성화 여부 | `bool` | `false` | no |
| <a name="input_stickiness_enabled"></a> [stickiness\_enabled](#input\_stickiness\_enabled) | 고정 세션 기능 활성화 여부 | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Targe Group 태그 | `map(string)` | `{}` | no |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | Target type: `instance` or `ip` or `alb` | `string` | `"instance"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Target Group ARN |
| <a name="output_id"></a> [id](#output\_id) | Target Group ID |
| <a name="output_name"></a> [name](#output\_name) | Target Group Name |
<!-- END_TF_DOCS -->