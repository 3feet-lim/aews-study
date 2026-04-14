# Lambda 정보
output "layer" {
  value = aws_lambda_layer_version.this
}

# Lambda ARN
output "arn" {
  value = aws_lambda_layer_version.this.arn
}