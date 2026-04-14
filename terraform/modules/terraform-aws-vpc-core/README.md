# Module : VPC Core

## Overview
KB One Cloud 내 AWS VPC를 생성 및 관리하기 위한 VPC-core 모듈입니다.

## Features
- vpc flow log 수집 기본 활성화 (`vpc_flowlog_enable = true`)
- igw 생성 기본 비활성화 (`igw_enable = false`)

## Usage
### secondary cidr 추가할 경우
```hcl
module "<Module Name>" {
  source = ""

  name = "test-vpc"
  cidr_block = "10.0.0.0/16"
  secondary_cidr_block = ["100.71.0.0/24"]
  tags = {
    "Servicegroup" : "pea"
    "Env" : "dev"
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
| [aws_flow_log.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_ipv4_cidr_block_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.flowlog_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | VPC의 CIDR 대역 | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | VPC의 이름 | `string` | n/a | yes |
| <a name="input_igw_enable"></a> [igw\_enable](#input\_igw\_enable) | Internet Gateway 생성 여부 | `bool` | `false` | no |
| <a name="input_igw_name"></a> [igw\_name](#input\_igw\_name) | Ingernet Gateway 이름 | `string` | `""` | no |
| <a name="input_log_destination_type"></a> [log\_destination\_type](#input\_log\_destination\_type) | VPC FlowLog 목적지 | `string` | `"s3"` | no |
| <a name="input_log_format"></a> [log\_format](#input\_log\_format) | VPC FlowLog의 수집 형태(Format) | `string` | `"${version} ${interface-id} ${srcaddr} ${dstaddr} ${srcport} ${dstport} ${protocol} ${packets} ${bytes} ${start} ${end} ${action} ${log-status} ${tcp-flags} ${pkt-srcaddr} ${pkt-dstaddr} ${flow-direction}"` | no |
| <a name="input_max_aggregation_interval"></a> [max\_aggregation\_interval](#input\_max\_aggregation\_interval) | VPC FlowLog의 수집 주기 | `number` | `60` | no |
| <a name="input_secondary_cidr_block"></a> [secondary\_cidr\_block](#input\_secondary\_cidr\_block) | VPC의 추가 CIDR 대역 | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | VPC 태그 | `map(string)` | `{}` | no |
| <a name="input_traffic_type"></a> [traffic\_type](#input\_traffic\_type) | VPC FlowLog 수집 대상 필터(Accept/Reject) | `string` | `"ALL"` | no |
| <a name="input_vpc_flowlog_bucket_name"></a> [vpc\_flowlog\_bucket\_name](#input\_vpc\_flowlog\_bucket\_name) | VPC FlowLog의 저장소 S3 버킷 이름 | `string` | `""` | no |
| <a name="input_vpc_flowlog_bucket_versioning"></a> [vpc\_flowlog\_bucket\_versioning](#input\_vpc\_flowlog\_bucket\_versioning) | VPC FlowLog의 저장소 S3의 버저닝 옵션 설정 | `string` | `"Enabled"` | no |
| <a name="input_vpc_flowlog_enable"></a> [vpc\_flowlog\_enable](#input\_vpc\_flowlog\_enable) | VPC FlowLog 활성화 여부 | `bool` | `true` | no |
| <a name="input_vpc_flowlog_name"></a> [vpc\_flowlog\_name](#input\_vpc\_flowlog\_name) | VPC FlowLog 이름 | `string` | `""` | no |
| <a name="input_vpc_flowlog_policy_name"></a> [vpc\_flowlog\_policy\_name](#input\_vpc\_flowlog\_policy\_name) | VPC FlowLog의 역할권한의 정책 이름 | `string` | `""` | no |
| <a name="input_vpc_flowlog_role_name"></a> [vpc\_flowlog\_role\_name](#input\_vpc\_flowlog\_role\_name) | VPC FlowLog의 역할권한 이름 | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->
