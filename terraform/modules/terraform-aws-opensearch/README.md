# Module: Opensearch

## Overview
AWS Opensearch 를 생성 / 관리하기 위한 모듈입니다.

## Features

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/opensearch/aws"
  version = "~> 1.0"  # Latest patch version

  domain_name = ""
  engine_version = ""
  instance_type = ""
  subnet_id = "subnet-123456"
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
| [aws_iam_service_linked_role.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_opensearch_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Opensearch 도메인 이름 | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Opensearch 엔진 버전 | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Opensearch 데이터노드 인스턴스 타입 | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Opensearch Subnet ID | `string` | n/a | yes |
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | Opensearch Access policy | `string` | `null` | no |
| <a name="input_anonymous_auth_enabled"></a> [anonymous\_auth\_enabled](#input\_anonymous\_auth\_enabled) | Opensearch 익명 접근 허용 여부 | `bool` | `false` | no |
| <a name="input_az_count"></a> [az\_count](#input\_az\_count) | Opensearch AZ 갯수 | `number` | `2` | no |
| <a name="input_ebs_enabled"></a> [ebs\_enabled](#input\_ebs\_enabled) | Opensearch 데이터노드 볼륨 연결 여부 | `bool` | `true` | no |
| <a name="input_encrypt_at_rest"></a> [encrypt\_at\_rest](#input\_encrypt\_at\_rest) | Opensearch 도메인 보안 호출 여부 | `bool` | `true` | no |
| <a name="input_enforce_https"></a> [enforce\_https](#input\_enforce\_https) | Opensearch 도메인 HTTPS 연결 여부 | `bool` | `true` | no |
| <a name="input_fgac_enabled"></a> [fgac\_enabled](#input\_fgac\_enabled) | Opensearch fine-grained access control (FGAC) 활성화 여부 | `bool` | `true` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Opensearch 데이터노드 인수턴스 갯수 | `number` | `1` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | Opensearch 데이터노드 볼륨 IOPS | `number` | `null` | no |
| <a name="input_master_enabled"></a> [master\_enabled](#input\_master\_enabled) | Opensearch 마스터노드 별도 구성 여부 | `bool` | `false` | no |
| <a name="input_master_user_arn"></a> [master\_user\_arn](#input\_master\_user\_arn) | Opensearch FGAC 마스터사용자 역할권한 | `string` | `null` | no |
| <a name="input_master_user_name"></a> [master\_user\_name](#input\_master\_user\_name) | Opensearch FGAC 마스터사용자 이름 | `string` | `null` | no |
| <a name="input_master_user_password"></a> [master\_user\_password](#input\_master\_user\_password) | Opensearch FGAC 마스터사용자 비밀번호 | `string` | `null` | no |
| <a name="input_node_to_node_encryption"></a> [node\_to\_node\_encryption](#input\_node\_to\_node\_encryption) | Opensearch 노드간 보안 연결 여부 | `bool` | `true` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Opensearch 보안 그릅 ID | `list(string)` | `[]` | no |
| <a name="input_throughput"></a> [throughput](#input\_throughput) | Opensearch 데이터노드 볼륨 IOPS(throughput in MB/s (gp3 only)) | `number` | `null` | no |
| <a name="input_tls_security_policy"></a> [tls\_security\_policy](#input\_tls\_security\_policy) | Opensearch TLS 정책 | `string` | `"Policy-Min-TLS-1-2-2019-07"` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Opensearch 데이터노드 볼륨 사이즈 | `number` | `100` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Opensearch 데이터노드 볼륨 타입 | `string` | `"gp3"` | no |
| <a name="input_warm_enabled"></a> [warm\_enabled](#input\_warm\_enabled) | Opensearch Warm 노드 활성 화 여부 | `bool` | `false` | no |
| <a name="input_zone_awareness_enabled"></a> [zone\_awareness\_enabled](#input\_zone\_awareness\_enabled) | Opensearch Multi-AZ 활성화 여부 | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
