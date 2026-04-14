# Module : EC2

## Overview
AWS EC2 인스턴스를 생성 / 관리하기 위한 모듈입니다.

## Feature
- 인스턴스 종료 방지 기본 활성화

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/ec2/aws"
  version = "~> 1.0"

  name = "test-ec2"
  ami = "ami-12345678"
  instance_type = "t3.micro"
  subnet_id = "subnet-12345678"
  vpc_security_group_ids = ["sg-12345678", "sg-56780987"]
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
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | Instance의 AMI ID | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance의 타입 | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Instance의 이름 | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Instance가 배치되는 Subnet ID | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | Instance의 보안 그룹 ID 목록 | `list(string)` | n/a | yes |
| <a name="input_delete_on_termination"></a> [delete\_on\_termination](#input\_delete\_on\_termination) | Instance 삭제시 Root 볼륨 삭제 여부 | `string` | `"true"` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | Instance의 삭제 보호 여부 | `string` | `"true"` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | Instance의 Root 볼륨 암호화 여부 | `string` | `"true"` | no |
| <a name="input_http_endpoint"></a> [http\_endpoint](#input\_http\_endpoint) | Metadata http 엔드포인트의 활성화 여부 | `string` | `"enabled"` | no |
| <a name="input_http_tokens"></a> [http\_tokens](#input\_http\_tokens) | Metadata 호출 시 토큰 사용 여부 `optional` 또는 `required` | `string` | `"required"` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | Instance의 인스턴스 프로파일 | `string` | `null` | no |
| <a name="input_instance_metadata_tags"></a> [instance\_metadata\_tags](#input\_instance\_metadata\_tags) | Instance 태그를 메타데이터 서비스로부터 조회 가능 허용 여부 | `string` | `"enabled"` | no |
| <a name="input_ipv6_address_count"></a> [ipv6\_address\_count](#input\_ipv6\_address\_count) | Instance의 IPv6이 주소 갯수 | `number` | `null` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Instance의 SSH KEY | `string` | `null` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Instance의 Private IP 주소 | `string` | `null` | no |
| <a name="input_source_dest_check"></a> [source\_dest\_check](#input\_source\_dest\_check) | Instance의 ENI의 출발지/목적지 체크 설정 옵션 | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for EC2 | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Instance의 User-Data | `string` | `null` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Instance의 Root 볼륨 사이즈 | `number` | `null` | no |
| <a name="input_volume_tags"></a> [volume\_tags](#input\_volume\_tags) | Tags for EC2 Volume | `map(string)` | `{}` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Instancedml Root 볼륨 타입 | `string` | `"gp3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | EC2 인스턴스 arn |
| <a name="output_ec2"></a> [ec2](#output\_ec2) | n/a |
| <a name="output_id"></a> [id](#output\_id) | EC2 인스턴스 id |
<!-- END_TF_DOCS -->
