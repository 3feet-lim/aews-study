####################################################################
# Module Name : VPC
# Module Desc : VPC를 생성합니다.
# Module Target Resource : VPC, VPC FLOWLOG
####################################################################

locals {
  project_code            = join("-", slice(split("-", var.name), 0, 4))
  vpc_flowlog_name        = var.vpc_flowlog_name == "" ? "${local.project_code}-flow-log" : var.vpc_flowlog_name
  igw_name                = var.igw_name == "" ? "${local.project_code}-igw" : var.igw_name
  vpc_flowlog_role_name   = var.vpc_flowlog_role_name == "" ? "${local.project_code}-vpc-flowlog-role" : var.vpc_flowlog_role_name
  vpc_flowlog_policy_name = var.vpc_flowlog_policy_name == "" ? "${local.project_code}-vpc-flowlog-policy" : var.vpc_flowlog_policy_name
  vpc_flowlog_bucket_name = var.vpc_flowlog_bucket_name == "" ? "${local.project_code}-vpc-flowlog-bucket" : var.vpc_flowlog_bucket_name
}

####################################################################
# VPC를 생성합니다.
####################################################################
resource "aws_vpc" "this" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = merge(
    { Name = var.name },
    var.tags
  )
}

####################################################################
# 두번째 CIDR 지정이 필요한 경우 생성합니다.
####################################################################
resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count = var.secondary_cidr_block == null ? 0 : length(var.secondary_cidr_block)

  vpc_id     = aws_vpc.this.id
  cidr_block = var.secondary_cidr_block[count.index]
}

####################################################################
# Internet Gateway를 생성합니다.
####################################################################
resource "aws_internet_gateway" "this" {
  count = var.igw_enable ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(
    { Name = local.igw_name }
  )
}

####################################################################
# Flowlog를 생성합니다.
####################################################################

# Flowlog를 생성
resource "aws_flow_log" "this" {
  count = var.vpc_flowlog_enable ? 1 : 0

  #iam_role_arn              = aws_iam_role.vpc_role[count.index].arn
  log_destination_type      = var.log_destination_type
  log_destination           = aws_s3_bucket.this[count.index].arn
  traffic_type              = var.traffic_type
  max_aggregation_interval  = var.max_aggregation_interval
  log_format                = var.log_format
  vpc_id                    = aws_vpc.this.id
  
  tags = merge(
    { Name = local.vpc_flowlog_name }
  )
}

# Flowlog에서 사용할 역할 권한에 신뢰정책
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Flowlog에서 사용할 역할 권한을 생성
resource "aws_iam_role" "this" {
  count = var.vpc_flowlog_enable ? 1 : 0

  name               = local.vpc_flowlog_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Flowlog 역할권한에서 사용할 정책
data "aws_iam_policy_document" "flowlog_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]

    resources = ["*"]
  }
}

# Flowlog 역할권한 및 정책
resource "aws_iam_role_policy" "this" {
  count = var.vpc_flowlog_enable ? 1 : 0

  name   = local.vpc_flowlog_policy_name
  role   = aws_iam_role.this[count.index].id
  policy = data.aws_iam_policy_document.flowlog_policy.json
}

# Flowlog 저장소 s3를 생성
resource "aws_s3_bucket" "this" {
  count = var.vpc_flowlog_enable ? 1 : 0

  bucket = local.vpc_flowlog_bucket_name
}

# Flowlog 저장소 s3정책 설정
resource "aws_s3_bucket_policy" "this" {
  count  = var.vpc_flowlog_enable ? 1 : 0
  bucket = aws_s3_bucket.this[count.index].id
  policy = data.aws_iam_policy_document.s3_policy[count.index].json
}

# S3 Versions 설정
resource "aws_s3_bucket_versioning" "this" {
  count = var.vpc_flowlog_enable ? 1 : 0

  bucket = aws_s3_bucket.this[count.index].id

  versioning_configuration {
    status = var.vpc_flowlog_bucket_versioning
  }
}

# Flowlog 저장소 s3정책
data "aws_iam_policy_document" "s3_policy" {
  count = var.vpc_flowlog_enable ? 1 : 0

  statement {
    sid    = "AWSVPCFlowLogsS3Delivery"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.this[count.index].arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = ["${data.aws_caller_identity.current.account_id}"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }

  statement {
    sid    = "AWSLogDeliveryAclCheck"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl",
    ]
    resources = [
      "${aws_s3_bucket.this[count.index].arn}"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = ["${data.aws_caller_identity.current.account_id}"]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }

  statement {
    sid    = "Stmt1704685164403"
    effect = "Deny"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.this[count.index].arn}/*"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

# Account ID 조회
data "aws_caller_identity" "current" {}

# Region 조회
data "aws_region" "current" {}