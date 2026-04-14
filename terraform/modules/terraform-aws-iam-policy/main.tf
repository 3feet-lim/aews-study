####################################################################
# Module Name : IAM Policy
# Module Desc : IAM Policy
####################################################################

####################################################################
# 역할 권한 정책을 매핑합니다.
####################################################################
resource "aws_iam_policy" "this" {
  name        = var.name
  path        = var.path
  description = var.description
  policy      = var.policy

  lifecycle {
    create_before_destroy = true
  }
}
