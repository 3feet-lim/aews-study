####################################################################
# Module Name : Lambda Function
# Module Desc : Lambda Function을 생성합니다.
####################################################################

####################################################################
# Lambda Function 생성
resource "aws_lambda_function" "this" {

  # Function Info
  function_name     = var.function_name
  description       = var.description
  filename          = var.filename
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
  s3_object_version = var.s3_object_version

  # Execution Role
  role = var.role

  # Function Spec
  handler                        = var.handler
  runtime                        = var.runtime
  architectures                  = var.architectures
  layers                         = var.layers
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  package_type                   = var.package_type
  publish                        = var.publish
  reserved_concurrent_executions = var.reserved_concurrent_executions
  skip_destroy                   = var.skip_destroy

  dynamic "environment" {
    for_each = var.variables != null ? [1] : []
    content {
      variables = {
        for k, v in var.variables : k => v
        if v != null
      }
    }

  }

  dynamic "vpc_config" {
    for_each = (
      length(var.subnet_ids) > 0
      && length(var.security_group_ids) > 0
    ) ? [1] : []
    content {
      security_group_ids = var.security_group_ids
      subnet_ids         = var.subnet_ids
    }
  }

  tags = var.tags

}