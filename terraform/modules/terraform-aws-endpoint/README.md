# Module : endpoint

## Overview
AWS VPC Endpoint를 생성 및 관리하기 위한 모듈입니다. 

## Feautres
- Gateway type Endpoint는 Route Table ID 지정
- Interface type Endpoint는 subnet, security group ID 지정

## Usage
```hcl
module <module_name> {
  source  = "tfe.kbonecloud.com/kbonecloud/endpoint/aws"
  version = "1.0.4"  # Latest version 확인

  vpc_id = "vpc-12345678"
  vpce_list = [
    # S3 Gateway endpoint
    {
      service_name      = "com.amazonaws.ap-northeast-2.s3"
      vpc_endpoint_type = "Gateway"
      route_table_ids = [
        "rtb-12345675", 
        "rtb-56789452"  
      ]
      vpce_name = "test-s3-gateway-endpoint"   
    },
    # Interface endpoint
    {
      service_name       = "com.amazonaws.ap-northeast-2.execute-api"
      vpc_endpoint_type  = "Interface"
      subnet_ids         = ["subnet-1234", "subnet-5678"]
      security_group_ids = ["sg-12345678"]
      vpce_name          = "test-api-endpoint" 
    },
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
| [aws_vpc_endpoint.endpoint-gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.endpoint-interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_dns_only_for_inbound_resolver_endpoint"></a> [private\_dns\_only\_for\_inbound\_resolver\_endpoint](#input\_private\_dns\_only\_for\_inbound\_resolver\_endpoint) | 인바운드 리졸버 엔드포인트 경로에서만 Private DNS 사용 제한 여부 | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC Endpoint가 배치될 VPC ID | `string` | n/a | yes |
| <a name="input_vpce_list"></a> [vpce\_list](#input\_vpce\_list) | VPC Endpoint 목록(Gateway/Interface) | <pre>list(object({<br/>    service_name        = string<br/>    vpc_endpoint_type   = string<br/>    route_table_ids     = optional(list(string))<br/>    subnet_ids          = optional(list(string))<br/>    security_group_ids  = optional(list(string))<br/>    private_dns_enabled = optional(bool, true)<br/>    vpce_name           = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint-gateway"></a> [endpoint-gateway](#output\_endpoint-gateway) | n/a |
| <a name="output_endpoint-interface"></a> [endpoint-interface](#output\_endpoint-interface) | n/a |
<!-- END_TF_DOCS -->
