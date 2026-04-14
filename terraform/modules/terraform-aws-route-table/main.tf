# ==================================================================
# Module Name : Route Table
# Module Desc : Route Table을 생성합니다.
# Module Target Resource : Route Table, Route Table Assocication, Route
# ==================================================================


# 라우팅 테이블 생성
resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = merge(
    { Name = var.name },
    var.tags
  )
}


# 라우팅 테이블 서브넷 지정
resource "aws_route_table_association" "this" {
  for_each = { for idx, id in var.subnet_ids : idx => id }

  subnet_id      = each.value
  route_table_id = aws_route_table.this.id
}


# 라우팅 설정
resource "aws_route" "this" {
  for_each = { for idx, route in coalesce(var.routes, []) : coalesce(route.destination_cidr_block, route.destination_prefix_list_id) => route
  if length(coalesce(var.routes, [])) > 0 }

  route_table_id = aws_route_table.this.id

  # Destination
  destination_cidr_block     = try(each.value.destination_cidr_block, null)
  destination_prefix_list_id = try(each.value.destination_prefix_list_id, null)

  # Target
  gateway_id                = try(each.value.gateway_id, null)
  nat_gateway_id            = try(each.value.nat_gateway_id, null)
  network_interface_id      = try(each.value.network_interface_id, null)
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
  vpc_endpoint_id           = try(each.value.vpc_endpoint_id, null)
  vpc_peering_connection_id = try(each.value.vpc_peering_connection_id, null)
}
