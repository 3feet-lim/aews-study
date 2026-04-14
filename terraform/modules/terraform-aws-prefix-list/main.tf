####################################################################
# Module Name : prefix-list
# Module Desc : prefix-list를 생성합니다.
####################################################################

####################################################################
# Prefix IP
resource "aws_ec2_managed_prefix_list" "this" {
  name           = var.name
  address_family = "IPv4"
  max_entries    = var.max_entries

  dynamic "entry" {
    for_each = var.entry
    content {
      cidr        = entry.value["cidr"]
      description = entry.value["description"]
    }
  }
}