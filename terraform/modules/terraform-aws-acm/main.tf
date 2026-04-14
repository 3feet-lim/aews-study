####################################################################
# Module Name : ACM
# Module Desc : 로컬에 있는 인증서 파일을 AWS ACM에 임포트
####################################################################

####################################################################
# ACM생성
resource "aws_acm_certificate" "this" {
  for_each = { for cert in var.certs : "${cert.cert_name}" => cert}

  # 파일로부터 읽은 값 주입
  certificate_body    = each.value.certificate_body
  private_key         = each.value.private_key
  certificate_chain   = each.value.certificate_chain

} 
