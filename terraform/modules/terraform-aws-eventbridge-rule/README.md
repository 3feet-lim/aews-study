# Module : Eventbridge-rule

## Overview
Eventbridge-rule 모듈을 생성 / 관리하기 위한 Terraform 모듈입니다. 

## Feature
- `event_pattern`, `schedule_expression` 중 하나는 필수로 입력해야 합니다.

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/eventbridge-rule/aws"
  version = "1.0.0"  # Latest version 확인

  name = "test-event-rule"
  event_pattern = jsonencode({
    detail-type = ["AWS Console Sign In via CloudTrail"]
  })
  targets = {
    target-1 = {
      arn = "arn:aws:events:ap-northeast-2:12345678:event-bus/test_event"
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
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | EventBridge rule name | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | EventBridge rule description | `string` | `null` | no |
| <a name="input_event_pattern"></a> [event\_pattern](#input\_event\_pattern) | EventBridge rule event pattern | `string` | `null` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | EventBridge rule arn for assume | `string` | `null` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | EventBridge rule schedule expression | `string` | `null` | no |
| <a name="input_state"></a> [state](#input\_state) | EventBridge rule state | `string` | `"ENABLED"` | no |
| <a name="input_targets"></a> [targets](#input\_targets) | EventBridge rule target list | <pre>map(object({<br/>    arn             = string<br/>    input           = optional(string)<br/>    input_path      = optional(string)<br/>    role_arn        = optional(string)<br/>    dead_letter_arn = optional(string)<br/>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->