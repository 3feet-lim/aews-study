####################################################################
# Module Name : IAM User
# Module Desc : IAM User
####################################################################

####################################################################
# IAM User
####################################################################
resource "aws_iam_user" "this" {
  name          = var.name
  path          = var.path
  force_destroy = var.force_destroy
}

# User -> Group 매핑
resource "aws_iam_user_group_membership" "this" {
  count  = length(var.groups) > 0 ? 1 : 0
  user   = aws_iam_user.this.name
  groups = var.groups
}
