# Module : EBS

## Overview
EBS volume을 생성 / 관리하기 위한 Terraform 모듈입니다. 

## Features

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/ebs/aws"
  version = "1.0.3"

  instance_id = "i-1234556"
  volume_info = [
    {name = "test-volume", type = "gp3", size = 50, availability_zone = "ap-northeast-2a", device_name = "/dev/sdb"}
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
| [aws_ebs_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_volume_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | Instance의 ID | `string` | n/a | yes |
| <a name="input_volume_info"></a> [volume\_info](#input\_volume\_info) | EBS 추가 볼륨의 정보 목록 | <pre>list(object({<br/>    name              = string<br/>    type              = string<br/>    size              = number<br/>    availability_zone = string<br/>    device_name       = string<br/>    iops              = optional(number)<br/>    throughput        = optional(number)<br/>    tags              = optional(map(string))<br/>  }))</pre> | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
