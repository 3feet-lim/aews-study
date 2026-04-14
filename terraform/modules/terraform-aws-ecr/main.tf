####################################################################
# Module Name : ECR 저장소
# Module Desc : ECR 저장소를 생성합니다.
####################################################################

###############################################
# ECR 저장소
###############################################
locals {
  repository_name = (
    var.namespace == "" ? var.name : "${var.namespace}/${var.name}"
  )
}

resource "aws_ecr_repository" "this" {
  name                 = local.repository_name
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.kms_key
  }

  tags = merge(
    { Name = local.repository_name },
    var.tags
  )
}

locals {
  default_lifecycle_policy = jsonencode({
    rules = [
      {
        "rulePriority" : 1,
        "description" : "${local.repository_name} Policy",
        "selection" : {
          "tagStatus" : "untagged",
          "countType" : "imageCountMoreThan",
          "countNumber" : 5
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_lifecycle_policy" "this" {
  count = var.create_lifecycle_policy ? 1 : 0

  repository = aws_ecr_repository.this.name
  policy = (
    var.lifecycle_policy_json != null ?
    var.lifecycle_policy_json :
    local.default_lifecycle_policy
  )
}