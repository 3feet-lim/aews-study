# Module : Elasticache Redis Cluster

## Overview
Elasticache Redis Cluster를 import 하기 위한 Terraform 모듈입니다.
*Redis 신규 생성 시에는 사용을 하지 않습니다*

## Feature
- replication group이 아닌 redis cluster 용
- 기존 구축된 인프라 import 시에만 사용하는 모듈

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/elasticache-redis-cluster/aws"
  version = "1.0.0"

  cluster_id = "test-redis"
  node_type = "cache.t2.micro"
  subnet_ids = ["subnet-1234"]
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
| [aws_elasticache_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | Redis Cluster 이름 | `string` | n/a | yes |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | Redis 노드의 인스턴스 type | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Redis 클러스터가 배치될 Subnet ID 목록 | `list(string)` | n/a | yes |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | 구성 변경 즉시 적용 여부, false 일 경우 유지보수 시간대에 적용 | `bool` | `true` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | 자동 minor 버젼 업그레이드 여부 | `bool` | `false` | no |
| <a name="input_cluster_tags"></a> [cluster\_tags](#input\_cluster\_tags) | Redis 클러스터 태그 | `map(string)` | `{}` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Redis OSS Engine 버전 | `string` | `"6.2"` | no |
| <a name="input_log_delivery_configuration"></a> [log\_delivery\_configuration](#input\_log\_delivery\_configuration) | Log Delivery 설정 목록 | <pre>list(object({<br/>    destination      = optional(string)<br/>    destination_type = optional(string, "cloudwatch-logs")<br/>    log_format       = optional(string, "json")<br/>    log_type         = optional(string, "slow-log")<br/>  }))</pre> | `[]` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | 유지보수가 수행되는 시간대 (UTC) | `string` | `"sun:15:00-sun:16:00"` | no |
| <a name="input_num_cache_nodes"></a> [num\_cache\_nodes](#input\_num\_cache\_nodes) | 클러스터 내 캐시 노드 수 | `number` | `1` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | Parameter group에 대한 설명 | `string` | `"default.redis6"` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | Redis 엔진 버전에 따른 Parameter Group 계열명 | `string` | `"redis6"` | no |
| <a name="input_parameter_group_list"></a> [parameter\_group\_list](#input\_parameter\_group\_list) | Parameter Group 이름 목록 | `map(string)` | `{}` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Parameter Group 이름 | `string` | `"default.redis6"` | no |
| <a name="input_port"></a> [port](#input\_port) | Redis 연결에 사용할 포트 | `number` | `6379` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Redis 클러스터가 속할 보안그룹 ID | `list(string)` | `[]` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | 자동 백업(snapshot)을 보관할 기간(일) | `number` | `30` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | 자동 스냅샷이 수행되는 시간대 (UTC) | `string` | `"15:00-16:00"` | no |
| <a name="input_subnet_group_description"></a> [subnet\_group\_description](#input\_subnet\_group\_description) | Subnet group에 대한설명 | `string` | `""` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | subnet group 이름 | `string` | `""` | no |
| <a name="input_subnet_group_tags"></a> [subnet\_group\_tags](#input\_subnet\_group\_tags) | Subnet Group 태그 | `map(string)` | `{}` | no |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | 전송 중 데이터 암호화(TLS) 활성화 여부 | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Primary endpoint |
| <a name="output_id"></a> [id](#output\_id) | Replication Group ID |
| <a name="output_parameter_group_name"></a> [parameter\_group\_name](#output\_parameter\_group\_name) | Parameter Group 이름 |
| <a name="output_subnet_group_name"></a> [subnet\_group\_name](#output\_subnet\_group\_name) | Subnet group 이름 |
<!-- END_TF_DOCS -->