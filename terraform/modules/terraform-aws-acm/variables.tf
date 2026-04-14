variable "certs" {
  description     = "도메인별 인증서 파일 경로"
  type            = list(object({
      cert_name   = string
      certificate_body   = string        # 서버 인증서 파일 경로
      private_key        = string        # 개인키 파일 경로
      certificate_chain  = optional(string)        # 체인(중간CA)파일 경로
    }))
  default = null
}
