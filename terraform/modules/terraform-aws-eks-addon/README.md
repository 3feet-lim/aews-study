# Module : EKS addon

## Overview
EKS addon을 생성/관리하기 위한 Terraform 모듈입니다.

## Feature
- configuration values는 따로 yaml / json 파일을 저장하고 읽어오는 방식을 사용한다. (권장)

## Usage
```hcl
# Config file 읽어오기
locals {
  coredns_config = try(file("./data/eks/coredns_config.yaml"), "")  
  ebs_csi_config = try(file("./data/eks/ebs_csi_config.yaml"), "")
}

module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/eks-addon/aws"
  version = "1.0.4"  # Latest version 확인

  cluster_name = module.test_eks.name  # EKS 클러스터 모듈 참조
  addon = [
    { addon_name = "vpc-cni", addon_version = "v1.20.4-eksbuild.2", service_account_role_arn = "", configuration_values = "" },
    { addon_name = "kube-proxy", addon_version = "v1.32.6-eksbuild.12", service_account_role_arn = "", configuration_values = "" },
    { addon_name = "coredns", addon_version = "v1.11.4-eksbuild.24", service_account_role_arn = "", configuration_values = local.coredns_config },
    { addon_name = "aws-ebs-csi-driver", addon_version = "v1.52.1-eksbuild.1", service_account_role_arn = "", configuration_values = local.ebs_csi_config }
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
| [aws_eks_addon.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS ADDON 배포대상 EKS 클러스터 | `string` | n/a | yes |
| <a name="input_addon"></a> [addon](#input\_addon) | EKS ADDON 목록 | <pre>list(object({<br/>    addon_name               = string<br/>    addon_version            = optional(string)<br/>    service_account_role_arn = optional(string)<br/>    configuration_values     = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_addon_versions"></a> [addon\_versions](#input\_addon\_versions) | EKS ADDON 기본 버전 | `map(string)` | <pre>{<br/>  "aws-ebs-csi-driver": "v1.51.1-eksbuild.1",<br/>  "aws-efs-csi-driver": "v2.1.13-eksbuild.1",<br/>  "coredns": "v1.11.4-eksbuild.2",<br/>  "kube-proxy": "v1.32.6-eksbuild.12",<br/>  "vpc-cni": "v1.20.4-eksbuild.1"<br/>}</pre> | no |
| <a name="input_resolve_conflicts_on_create"></a> [resolve\_conflicts\_on\_create](#input\_resolve\_conflicts\_on\_create) | EKS ADDON 생성 방식 | `string` | `"OVERWRITE"` | no |
| <a name="input_resolve_conflicts_on_update"></a> [resolve\_conflicts\_on\_update](#input\_resolve\_conflicts\_on\_update) | EKS ADDON 업데이트 방식 | `string` | `"OVERWRITE"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->