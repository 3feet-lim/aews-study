####################################################################
# Module Name : Subnet
# Module Desc : Subnet을 생성합니다.
# Module Target Resource : SUBNET
####################################################################

####################################################################
# Private subnet 생성
####################################################################
resource "aws_subnet" "this" {
  for_each = { for subnet in var.subnets : "${subnet.name}" => subnet }
  vpc_id   = var.vpc_id

  cidr_block              = each.value.cidr_block
  availability_zone_id    = each.value.availability_zone_id
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(
    { Name = each.value.name },
    each.value.tags
  )
}
