####################################################################
# Module Name : IAM
# Module Desc : Instance Profile
####################################################################

####################################################################
# EC2 Role
####################################################################
resource "aws_iam_role" "this" {
  name               = var.name
  description        = var.description
  assume_role_policy = var.assume_role_policy
}

####################################################################
# 역할 권한 프로파일을 생성합니다.
####################################################################
resource "aws_iam_instance_profile" "this" {
  name = var.name
  role = aws_iam_role.this.name
}

####################################################################
# 역할 권한 정책을 매핑합니다.
####################################################################
resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for idx, arn in var.policy_arns : idx => arn }

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
