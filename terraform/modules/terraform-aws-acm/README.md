# Module ACM

## Overview
AWS Certificate Manager SSL/TLS 인증서를 생성 / 관리하기 위한 모듈입니다.

## Feature
- certificate_body, private_key, certificate_chain 에 들어갈 값은 Terraform Variables를 사용합니다. (Sensitive)

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/acm/aws"
  version = "1.0.2"

  certs = [
    { "cert_name" = "test-acm", "certificate_body" = var.test_cert, "private_key" = var.test_key, "certificate_chain" = var.test_ca },
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
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certs"></a> [certs](#input\_certs) | 도메인별 인증서 파일 | <pre>list(object({<br/>    cert_name         = string<br/>    certificate_body  = string<br/>    private_key       = string<br/>    certificate_chain = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm"></a> [acm](#output\_acm) | ACM 생성 정보 |
<!-- END_TF_DOCS -->