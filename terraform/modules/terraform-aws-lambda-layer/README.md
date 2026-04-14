# Module: Lambda Function

## Overview
AWS Lambda Layer 를 생성 / 관리하기 위한 모듈입니다.

## Features

## Usage
```hcl
module <module_name> {
  source = "tfe.kbonecloud.com/kbonecloud/lambda-layer/aws"
  version = "~> 1.0"

  name = "test-lambda-layer"
  compatible_runtimes = ["python3.11", "python3.12"]
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
| [aws_lambda_layer_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compatible_runtimes"></a> [compatible\_runtimes](#input\_compatible\_runtimes) | Lambda Layer Runtimes 환경 | `list(string)` | n/a | yes |
| <a name="input_layer_name"></a> [layer\_name](#input\_layer\_name) | Lambda Layer 이름 | `string` | n/a | yes |
| <a name="input_compatible_architectures"></a> [compatible\_architectures](#input\_compatible\_architectures) | Lambda Layer 호환 아키텍처 타입 | `string` | `"x86_64"` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Lambda Layer 파일 이름/경로 | `string` | `null` | no |
| <a name="input_license_info"></a> [license\_info](#input\_license\_info) | Lambda Layer 라이센스 정보 | `string` | `null` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | Lambda Layer S3 파일 버킷이름 | `string` | `null` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | Lambda Layer S3 파일  Key 값 | `string` | `null` | no |
| <a name="input_s3_object_version"></a> [s3\_object\_version](#input\_s3\_object\_version) | Lambda Layer S3 파일의 버전 정보 | `string` | `null` | no |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | Lambda Layer 이전 버전 유지여부 | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Lambda ARN |
| <a name="output_layer"></a> [layer](#output\_layer) | Lambda 정보 |
<!-- END_TF_DOCS -->