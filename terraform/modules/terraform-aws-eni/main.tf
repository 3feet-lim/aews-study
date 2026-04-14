####################################################################
# Module Name : eni
# Module Desc : eni를 생성합니다.
####################################################################

####################################################################
# eni를 생성
resource "aws_network_interface" "this" {
  for_each        = var.enis
  subnet_id       = each.value.subnet_id
  security_groups = try(each.value.security_group_ids, [])

  private_ip        = try(each.value.private_ip, null)
  private_ips       = try(each.value.secondary_private_ipsry, null)
  private_ips_count = try(each.value.secondary_private_ip_count, null)

  #IPv6 자동 할당
  ipv6_address_count = try(each.value.ipv6_address_count, 0)
  source_dest_check  = try(each.value.source_dest_check, true)

  #인터페이스 타입 ("ENA", "EFA with ENA", "EFA-only")
  interface_type = try(each.value.interface_type, null)
  description    = try(each.value.description, null)
}

resource "aws_network_interface_attachment" "this" {
  for_each = {
    for k, v in var.enis :
    k => v if try(v.attachment != null, false)
  }

  instance_id          = each.value.attachment.instance_id
  network_interface_id = aws_network_interface.this[each.key].id
  device_index         = each.value.attachment.device_index
}