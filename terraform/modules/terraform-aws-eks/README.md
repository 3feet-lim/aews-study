# Module : EKS

## Overview
EKS 클러스터를 생성 / 관리하기 위한 Terraform 모듈입니다.

## Features
- EKS 클러스터 로그 기본 활성화 (비활성화시 `cluster_log_enable=false`, `enabled_cluster_log_types=null` 처리)

## Usage
```hcl
module "<Module Name>" {
  source  = "tfe.kbonecloud.com/kbonecloud/eks/aws"
  version = "1.0.2"  # Latest version 확인

  name = "kb0-kgq-starplanform-dev-eks-cluster"
  vpc_id = module.test_vpc.vpc_id
  subnet_ids = [
    module.test_subnet.subnet_ids[1],  # subnet id
    module.test_subnet.subnet_ids[2]
  ]
  endpoint_public_access = true
  role_arn = module.test_eks_cluster_role.arn
  security_group_ids = [module.test_eks_cluster_sg.id]
  enable_default_addon = false
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eks_access_entry.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_entry) | resource |
| [aws_eks_access_policy_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_policy_association) | resource |
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [tls_certificate.eks-cluster-oidc-url](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | EKS 클러스터 버전 | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | EKS 클러스터 이름 | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | EKS 클러스터의 역할권한 ARN | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | EKS 클러스터가 배치되는 Subnet ID | `list(string)` | n/a | yes |
| <a name="input_access_entry"></a> [access\_entry](#input\_access\_entry) | EKS 클러스터의 Access Entry 목록 | <pre>list(object({<br/>    principal_arn     = string<br/>    policy_arn        = string<br/>    type              = optional(string)<br/>    scope_type        = optional(string)<br/>    kubernetes_groups = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_authentication_mode"></a> [authentication\_mode](#input\_authentication\_mode) | EKS 클러스터의 인증권한 모드 | `string` | `"API_AND_CONFIG_MAP"` | no |
| <a name="input_bootstrap_cluster_creator_admin_permissions"></a> [bootstrap\_cluster\_creator\_admin\_permissions](#input\_bootstrap\_cluster\_creator\_admin\_permissions) | EKS 클러스터의 부트스르랩 여부 | `bool` | `true` | no |
| <a name="input_bootstrap_self_managed_addons"></a> [bootstrap\_self\_managed\_addons](#input\_bootstrap\_self\_managed\_addons) | 클러스터 생성 시, aws-cni, kube-proxy, coreDNS 등의 기본 unmanaged add-on 자동 설치 여부 | `bool` | `true` | no |
| <a name="input_cluster_log_enable"></a> [cluster\_log\_enable](#input\_cluster\_log\_enable) | EKS 클러스터 로그 활성화 여부 | `bool` | `true` | no |
| <a name="input_enabled_cluster_log_types"></a> [enabled\_cluster\_log\_types](#input\_enabled\_cluster\_log\_types) | EKS 클러스터의 로그 활성화 및 대상 | `list(string)` | <pre>[<br/>  "api",<br/>  "audit",<br/>  "authenticator",<br/>  "controllerManager",<br/>  "scheduler"<br/>]</pre> | no |
| <a name="input_endpoint_private_access"></a> [endpoint\_private\_access](#input\_endpoint\_private\_access) | EKS 클러스터 Private 접근 여부 | `bool` | `true` | no |
| <a name="input_endpoint_public_access"></a> [endpoint\_public\_access](#input\_endpoint\_public\_access) | EKS 클러스터 Public 접근 여부 | `bool` | `false` | no |
| <a name="input_ip_family"></a> [ip\_family](#input\_ip\_family) | EKS 클러스터의 IP 패밀리 | `string` | `"ipv4"` | no |
| <a name="input_key_arn"></a> [key\_arn](#input\_key\_arn) | EKS 클러스터의 암호화 Key | `string` | `null` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | EKS 클러스터 로그 보관 기간 | `number` | `7` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | EKS 클러스터에 설정되는 추가 보안 그룹 ID | `list(string)` | `[]` | no |
| <a name="input_service_ipv4_cidr"></a> [service\_ipv4\_cidr](#input\_service\_ipv4\_cidr) | EKS 클러스터의 서비스 IP CIDR | `string` | `"172.20.0.0/16"` | no |
| <a name="input_support_type"></a> [support\_type](#input\_support\_type) | EKS 클러스터의 Support 타입 | `string` | `"STANDARD"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | EKS 클러스터의 태그 | `map(string)` | `{}` | no |
| <a name="input_thumbprint_list"></a> [thumbprint\_list](#input\_thumbprint\_list) | EKS OIDC Provider Thumbprint 리스트 | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks"></a> [eks](#output\_eks) | n/a |
| <a name="output_oidc"></a> [oidc](#output\_oidc) | n/a |
<!-- END_TF_DOCS -->
