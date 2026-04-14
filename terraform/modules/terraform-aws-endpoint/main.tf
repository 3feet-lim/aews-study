####################################################################
# Module Name : Endpoint 
# Module Desc : Endpoint를 생성합니다.
# Module Target Resource : Endpoint(Gateway, Interface)
####################################################################

####################################################################
# Endpoint를 생성합니다.
####################################################################
# Gateway Endpoint 생성
resource "aws_vpc_endpoint" "endpoint_gateway" {
  for_each = { for vpce in var.vpce_list : "${vpce.vpce_name}" => vpce
    if vpce.vpc_endpoint_type == "Gateway"
  }

  vpc_id            = var.vpc_id
  service_name      = each.value.service_name
  vpc_endpoint_type = each.value.vpc_endpoint_type
  route_table_ids   = each.value.route_table_ids

  tags = merge(
    { Name = each.value.vpce_name },
    var.tags
  )
}

# Interface Endpoint 생성
resource "aws_vpc_endpoint" "endpoint_interface" {
  for_each = { for vpce in var.vpce_list : "${vpce.vpce_name}" => vpce
    if vpce.vpc_endpoint_type == "Interface"
  }

  vpc_id             = var.vpc_id
  service_name       = each.value.service_name
  vpc_endpoint_type  = each.value.vpc_endpoint_type
  subnet_ids         = each.value.subnet_ids
  security_group_ids = each.value.security_group_ids

  private_dns_enabled = try(each.value.private_dns_enabled, null)

  dynamic "dns_options" {
    for_each = each.value.service_name == "com.amazonaws.ap-northeast-2.s3" ? [1] : []
    content {
      dns_record_ip_type                             = "ipv4"
      private_dns_only_for_inbound_resolver_endpoint = var.private_dns_only_for_inbound_resolver_endpoint
    }
  }

  tags = merge(
    { Name = each.value.vpce_name },
    var.tags
  )

  depends_on = [ aws_vpc_endpoint.endpoint_gateway ]
}
