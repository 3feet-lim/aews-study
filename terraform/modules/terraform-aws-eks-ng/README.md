# Module : EKS Nodegroup

## Overview
EKS 노드그룹을 생성 / 관리하기 위한 Terraform 모듈입니다.

## Features
- update_config 변수는 필수 변수. max_unavailable / max_unavailable_percentage 중에 하나만 지정.

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/eks-ng/aws"
  version = "1.0.4" # Latest version 확인

  cluster_name = module.test_eks.name  # EKS 클러스터 모듈 참조
  node_group_name = "test-eks-ng"
  node_role_arn = module.eks_ng_role.arn  # IAM Role 모듈 참조
  subnet_ids = [module.private_subnet_1.id, module.private_subnet_2.id]
  max_size = 1
  min_size = 1
  desired_size = 1

  update_config = {
    max_unavailable = 1
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
| [aws_eks_node_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | NodeGroup이 연결될 eks 클러스터 이름 | `string` | n/a | yes |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | Auto scaling 목표 노드 수 | `number` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Auto scaling 최대 노드 수 | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Auto scaling 최소 노드 수 | `number` | n/a | yes |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | EKS Node Group 이름 | `string` | n/a | yes |
| <a name="input_node_role_arn"></a> [node\_role\_arn](#input\_node\_role\_arn) | Worker node가 사용할 IAM Role arn | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Worker node가 배치될 서브넷 IDs | `list(string)` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | 노드에 적용할 Kubernetes Labels | `map(string)` | `{}` | no |
| <a name="input_launch_template_name"></a> [launch\_template\_name](#input\_launch\_template\_name) | Launch Template 이름 | `string` | `null` | no |
| <a name="input_launch_template_version"></a> [launch\_template\_version](#input\_launch\_template\_version) | Launch Template 버전 | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Node Group에 적용할 태그 | `map(string)` | `{}` | no |
| <a name="input_taints"></a> [taints](#input\_taints) | 노드에 적용할 Kubernetes tains | <pre>list(object({<br/>    key    = string<br/>    value  = optional(string)<br/>    effect = string<br/>  }))</pre> | `[]` | no |
| <a name="input_update_config"></a> [update\_config](#input\_update\_config) | Roling 업데이트 설정. 최대로 사용할 수 없는 노드의 수 또는 비율 지정 | <pre>object({<br/>    max_unavailable            = optional(number)<br/>    max_unavailable_percentage = optional(number)<br/>  })</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
