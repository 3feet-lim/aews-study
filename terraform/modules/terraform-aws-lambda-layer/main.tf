####################################################################
# Module Name : Lambda Layer
# Module Desc : Lambda Layer를 생성합니다.
####################################################################

####################################################################
# Lambda Layer 생성
resource "aws_lambda_layer_version" "this" {

  layer_name          = var.layer_name
  compatible_runtimes = var.compatible_runtimes
  license_info        = var.license_info

  filename          = var.filename
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
  s3_object_version = var.s3_object_version
  skip_destroy      = var.skip_destroy
}
