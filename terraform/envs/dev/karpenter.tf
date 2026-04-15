########################
# Karpenter Controller IAM Role (Pod Identity)
########################

# Karpenter Controller IAM Role
resource "aws_iam_role" "karpenter_controller" {
  name = "${var.project_name}-karpenter-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "pods.eks.amazonaws.com" }
      Action    = ["sts:AssumeRole", "sts:TagSession"]
    }]
  })
}

# Karpenter Controller 정책
resource "aws_iam_role_policy" "karpenter_controller" {
  name = "${var.project_name}-karpenter-controller-policy"
  role = aws_iam_role.karpenter_controller.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateFleet", "ec2:CreateLaunchTemplate", "ec2:CreateTags",
          "ec2:DeleteLaunchTemplate", "ec2:DescribeAvailabilityZones",
          "ec2:DescribeImages", "ec2:DescribeInstances", "ec2:DescribeInstanceTypeOfferings",
          "ec2:DescribeInstanceTypes", "ec2:DescribeLaunchTemplates",
          "ec2:DescribeSecurityGroups", "ec2:DescribeSubnets",
          "ec2:RunInstances", "ec2:TerminateInstances",
          "iam:PassRole", "iam:GetInstanceProfile", "iam:CreateInstanceProfile",
          "iam:DeleteInstanceProfile", "iam:TagInstanceProfile",
          "iam:AddRoleToInstanceProfile", "iam:RemoveRoleFromInstanceProfile",
          "iam:ListInstanceProfiles", "iam:ListInstanceProfilesForRole",
          "pricing:GetProducts", "ssm:GetParameter", "eks:DescribeCluster",
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["sqs:DeleteMessage", "sqs:GetQueueAttributes", "sqs:GetQueueUrl", "sqs:ReceiveMessage"]
        Resource = aws_sqs_queue.karpenter.arn
      },
    ]
  })
}

# Pod Identity Association: karpenter SA ↔ IAM Role 매핑
resource "aws_eks_pod_identity_association" "karpenter" {
  cluster_name    = module.eks.name
  namespace       = "kube-system"
  service_account = "karpenter"
  role_arn        = aws_iam_role.karpenter_controller.arn
}

########################
# Karpenter Node IAM
########################

# Karpenter가 프로비저닝하는 노드용 IAM Role
resource "aws_iam_role" "karpenter_node" {
  name = "${var.project_name}-karpenter-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "karpenter_node_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ])

  role       = aws_iam_role.karpenter_node.name
  policy_arn = each.value
}

# EKS Access Entry: Karpenter 노드가 클러스터에 조인할 수 있도록
resource "aws_eks_access_entry" "karpenter_node" {
  cluster_name  = module.eks.name
  principal_arn = aws_iam_role.karpenter_node.arn
  type          = "EC2_LINUX"
}

########################
# Karpenter SQS
########################

# Karpenter 인터럽션 핸들링용 SQS Queue
resource "aws_sqs_queue" "karpenter" {
  name                      = "${var.project_name}-karpenter"
  message_retention_seconds = 300
  sqs_managed_sse_enabled   = true
}

resource "aws_sqs_queue_policy" "karpenter" {
  queue_url = aws_sqs_queue.karpenter.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = ["events.amazonaws.com", "sqs.amazonaws.com"] }
      Action    = "sqs:SendMessage"
      Resource  = aws_sqs_queue.karpenter.arn
    }]
  })
}

########################
# Karpenter EventBridge
########################

# EC2 인스턴스 상태 변경
resource "aws_cloudwatch_event_rule" "karpenter_instance_state" {
  name = "${var.project_name}-karpenter-instance-state"
  event_pattern = jsonencode({ source = ["aws.ec2"], "detail-type" = ["EC2 Instance State-change Notification"] })
}

resource "aws_cloudwatch_event_target" "karpenter_instance_state" {
  rule = aws_cloudwatch_event_rule.karpenter_instance_state.name
  arn  = aws_sqs_queue.karpenter.arn
}

# Spot 인터럽션
resource "aws_cloudwatch_event_rule" "karpenter_spot_interruption" {
  name = "${var.project_name}-karpenter-spot-interruption"
  event_pattern = jsonencode({ source = ["aws.ec2"], "detail-type" = ["EC2 Spot Instance Interruption Warning"] })
}

resource "aws_cloudwatch_event_target" "karpenter_spot_interruption" {
  rule = aws_cloudwatch_event_rule.karpenter_spot_interruption.name
  arn  = aws_sqs_queue.karpenter.arn
}

# 리밸런스 권고
resource "aws_cloudwatch_event_rule" "karpenter_rebalance" {
  name = "${var.project_name}-karpenter-rebalance"
  event_pattern = jsonencode({ source = ["aws.ec2"], "detail-type" = ["EC2 Instance Rebalance Recommendation"] })
}

resource "aws_cloudwatch_event_target" "karpenter_rebalance" {
  rule = aws_cloudwatch_event_rule.karpenter_rebalance.name
  arn  = aws_sqs_queue.karpenter.arn
}

# AWS Health 이벤트
resource "aws_cloudwatch_event_rule" "karpenter_health" {
  name = "${var.project_name}-karpenter-health"
  event_pattern = jsonencode({ source = ["aws.health"], "detail-type" = ["AWS Health Event"] })
}

resource "aws_cloudwatch_event_target" "karpenter_health" {
  rule = aws_cloudwatch_event_rule.karpenter_health.name
  arn  = aws_sqs_queue.karpenter.arn
}
