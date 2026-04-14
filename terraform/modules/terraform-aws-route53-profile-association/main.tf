####################################################################
# Module Name : Route53 Profile Association
# Module Desc : Route53 Profile Association 생성
####################################################################

####################################################################
# Route53 Profile Association 생성
resource "aws_route53profiles_association" "this" {

  name        = var.name
  profile_id  = var.profile_id
  resource_id = var.resource_id

  tags = merge(
    { Name = var.name },
    var.tags
  )
}