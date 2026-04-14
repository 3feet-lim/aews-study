# Module: Lambda Function

## Overview
AWS Lambda Function 을 생성 / 관리하기 위한 모듈입니다.

## Features

## Usage
```hcl
module <module_name> {
  source = 
  version = "~> 1.0"

  name = "test-lambda"
  role = "arn::aws::xxxxxxx" # Execution Role
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
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Lambda Function의 이름 | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | Lambda Function의 실행 핸들러 지정 | `string` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | Lambda Function의 역할 권한 | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda Function의 실행 환경 | `string` | n/a | yes |
| <a name="input_source_code_hash"></a> [source\_code\_hash](#input\_source\_code\_hash) | Lambda Function소스코드 Hash 값 | `string` | n/a | yes |
| <a name="input_architectures"></a> [architectures](#input\_architectures) | Lambda Function의 실행 아키텍처 | `list(string)` | <pre>[<br/>  "x86_64"<br/>]</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | Lambda Function의 설명 | `string` | `null` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Lambda Function의 소스 파일 경로/이름 | `string` | `null` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | Lambda Function의 실행 환경 참조 Layer | `list(string)` | `null` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Lambda Function의 메모리 리소스 사이즈 | `number` | `128` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | Lambda Function의 Package 타입 | `string` | `"Zip"` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Lambda Function의 생성/수정후 배포 여부 | `bool` | `false` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | Lambda Function의 동시 실행 갯수 제한 | `number` | `-1` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | Lambda Function의 S3 소스 파일 버킷 | `string` | `null` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | Lambda Function의 S3 소스 파일 Key | `string` | `null` | no |
| <a name="input_s3_object_version"></a> [s3\_object\_version](#input\_s3\_object\_version) | Lambda Function의 S3 소스 파일 버전 | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Lambda Function의 보안 그룹 ID | `list(string)` | `[]` | no |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | Lambda Function의 신규 Layer 유지 여부 | `bool` | `false` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Lambda Function의 서브넷 ID | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Lambda Function의 태그 | `map(string)` | `null` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Lambda Function의 실행 타입아웃 지정 | `number` | `3` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | Lambda Function의 환경 변수 | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_lambda"></a> [lambda](#output\_lambda) | Lambda 정보 |
<!-- END_TF_DOCS -->