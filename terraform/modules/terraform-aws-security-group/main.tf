####################################################################
# Module Name : SECURITY GROUP
# Module Desc : Security Group 생성 모듈
####################################################################

####################################################################
# SECURITY GROUP 생성
####################################################################
resource "aws_security_group" "this" {
  # SG Group 기본 설정 정보
  name                   = var.name
  vpc_id                 = var.vpc_id
  description            = var.description
  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(
    { Name = var.name },
    var.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = var.ingress

  security_group_id = aws_security_group.this.id

  description = try(each.value.description, null)

  from_port   = each.value.ip_protocol != "-1" ? try(each.value.from_port, null) : null
  to_port     = each.value.ip_protocol != "-1" ? try(each.value.to_port, null) : null
  ip_protocol = try(each.value.ip_protocol, null)

  cidr_ipv4                    = try(each.value.cidr_ipv4, null)
  cidr_ipv6                    = try(each.value.cidr_ipv6, null)
  prefix_list_id               = try(each.value.prefix_list_id, null)
  referenced_security_group_id = coalesce(try(each.value.self, false), false) ? aws_security_group.this.id : try(each.value.referenced_security_group_id, null)

  tags = try(each.value.tags, {})
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = var.egress

  security_group_id = aws_security_group.this.id

  description = try(each.value.description, null)

  from_port   = each.value.ip_protocol != "-1" ? try(each.value.from_port, null) : null
  to_port     = each.value.ip_protocol != "-1" ? try(each.value.to_port, null) : null
  ip_protocol = try(each.value.ip_protocol, null)

  cidr_ipv4                    = try(each.value.cidr_ipv4, null)
  cidr_ipv6                    = try(each.value.cidr_ipv6, null)
  prefix_list_id               = try(each.value.prefix_list_id, null)
  referenced_security_group_id = coalesce(try(each.value.self, false), false) ? aws_security_group.this.id : try(each.value.referenced_security_group_id, null)

  tags = try(each.value.tags, {})
}
