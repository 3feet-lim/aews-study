####################################################################
# Module Name : Natgateway
# Module Desc : Natgateway를 생성합니다.
# Module Target Resource : SUBNET, NAT GATEWAY(Private)
####################################################################

####################################################################
# NAT Gateway를 생성합니다.
####################################################################
resource "aws_eip" "this" {
  for_each = {
    for nat in var.natgateway : "${nat.name}" => nat
    if nat.connectivity_type == "public"
  }

  domain = "vpc"
  tags = merge(
    { Name = "${each.value.name}-eip" },
    var.eip_tags
  )
}

resource "aws_nat_gateway" "natgateways" {
  for_each = { for nat in var.natgateway : "${nat.name}" => nat }

  allocation_id     = each.value.connectivity_type == "public" ? aws_eip.this[each.key].id : null
  connectivity_type = each.value.connectivity_type
  subnet_id         = each.value.subnet_id

  tags = merge(
    { Name = each.value.name },
    var.tags
  )
}
