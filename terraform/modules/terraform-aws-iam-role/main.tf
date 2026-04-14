####################################################################
# Module Name : IAM Role
# Module Desc : IAM Role
####################################################################

####################################################################
# IAM Role
####################################################################
resource "aws_iam_role" "this" {
  name               = var.name
  description        = var.description
  assume_role_policy = var.assume_role_policy

  lifecycle {
    create_before_destroy = true
  }
}

####################################################################
# 역할 권한 정책을 매핑합니다.
####################################################################
resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for idx, arn in var.policy_arns : idx => arn }

  role       = aws_iam_role.this.name
  policy_arn = each.value
}