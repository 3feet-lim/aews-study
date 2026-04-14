# Module : EFS

## Overview
EFS 모듈을 생성 / 관리하기 위한 Terraform 모듈입니다. 

## Features

## Usage
```hcl
module <module_name> {
  source = "tfe.kbonecloud.com/kbonecloud/efs/aws"
  version = "~> 1.0" # Latest patch version

  name = "test-efs"
  security_groups = ["sg-123456", "sg-56713123"]
  subnet_ids = ["subnet-12345676"]
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
| [aws_efs_access_point.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_backup_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_backup_policy) | resource |
| [aws_efs_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | EFS의 이름 | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | EFS의 보안 그룹 목록 | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | EFS의 Subnet Id 목록 | `list(string)` | n/a | yes |
| <a name="input_access_point"></a> [access\_point](#input\_access\_point) | EFS  Access Point 목록 | <pre>list(object({<br/>    name        = optional(string)<br/>    path        = optional(string)<br/>    owner_uid   = optional(string)<br/>    owner_gid   = optional(string)<br/>    permissions = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_automatic_backup_status"></a> [automatic\_backup\_status](#input\_automatic\_backup\_status) | EFS 자동 백업 상태 여부 | `string` | `null` | no |
| <a name="input_availability_zone_name"></a> [availability\_zone\_name](#input\_availability\_zone\_name) | EFS 단일존 사용시 AZ 명 지정 | `string` | `null` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | EFS 암호화 여부 | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | EFS 암호화 키 설정 | `string` | `null` | no |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | EFS 성능 모드 설정 | `string` | `null` | no |
| <a name="input_provisioned_throughput_in_mibps"></a> [provisioned\_throughput\_in\_mibps](#input\_provisioned\_throughput\_in\_mibps) | EFS 프로비전 처리량 (MiB/s) | `string` | `null` | no |
| <a name="input_replication_overwrite"></a> [replication\_overwrite](#input\_replication\_overwrite) | EFS 복제 덥어쓰기 활성화 여부 | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | EFS 태그 | `map(string)` | `null` | no |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | EFS 처리량 모드 설정 | `string` | `null` | no |
| <a name="input_transition_to_archive"></a> [transition\_to\_archive](#input\_transition\_to\_archive) | EFS Archive 스케줄 일정 | `string` | `null` | no |
| <a name="input_transition_to_ia"></a> [transition\_to\_ia](#input\_transition\_to\_ia) | EFS IA 전환 스케줄 설정 | `string` | `null` | no |
| <a name="input_transition_to_primary_storage_class"></a> [transition\_to\_primary\_storage\_class](#input\_transition\_to\_primary\_storage\_class) | EFS Standard Clas 전환 정책 | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
