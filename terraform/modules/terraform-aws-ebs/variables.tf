# EBS Info
variable "volume_info" {
  description = "EBS 추가 볼륨의 정보 목록"
  type = list(object({
    name              = string
    type              = string
    size              = number
    availability_zone = string
    device_name       = string
    iops              = optional(number)
    throughput        = optional(number)
    tags              = optional(map(string))
  }))
  default = null
}

# Instance ID
variable "instance_id" {
  description = "Instance의 ID"
  type        = string
}
