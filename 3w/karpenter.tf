########################
# Karpenter IRSA, SQS, EventBridge, Node IAM, Helm
########################

locals {
  karpenter_namespace = "kube-system"
  karpenter_sa_name   = "karpenter"
}

# Karpenter Controller IRSA
module "karpenter_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${var.ClusterBaseName}-karpenter"

  attach_karpenter_controller_policy = true
  karpenter_controller_cluster_id    = module.eks.cluster_name
  karpenter_controller_node_iam_role_arns = [
    aws_iam_role.karpenter_node.arn
  ]
  karpenter_sqs_queue_arn = aws_sqs_queue.karpenter.arn

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["${local.karpenter_namespace}:${local.karpenter_sa_name}"]
    }
  }
}

# Karpenter Instance Profile 관리 추가 권한
resource "aws_iam_role_policy" "karpenter_instance_profile" {
  name = "${var.ClusterBaseName}-karpenter-instance-profile"
  role = module.karpenter_irsa.iam_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "iam:GetInstanceProfile",
        "iam:CreateInstanceProfile",
        "iam:DeleteInstanceProfile",
        "iam:TagInstanceProfile",
        "iam:AddRoleToInstanceProfile",
        "iam:RemoveRoleFromInstanceProfile",
        "iam:ListInstanceProfiles",
        "iam:ListInstanceProfilesForRole"
      ]
      Resource = "*"
    }]
  })
}

# Karpenter Node IAM Role
resource "aws_iam_role" "karpenter_node" {
  name = "${var.ClusterBaseName}-karpenter-node"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
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

resource "aws_iam_instance_profile" "karpenter_node" {
  name = "${var.ClusterBaseName}-karpenter-node"
  role = aws_iam_role.karpenter_node.name
}

# EKS Access Entry for Karpenter nodes
resource "aws_eks_access_entry" "karpenter_node" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_iam_role.karpenter_node.arn
  type          = "EC2_LINUX"
}

# SQS Queue for Karpenter interruption handling
resource "aws_sqs_queue" "karpenter" {
  name                      = "${var.ClusterBaseName}-karpenter"
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

# EventBridge Rules
resource "aws_cloudwatch_event_rule" "karpenter_instance_state" {
  name = "${var.ClusterBaseName}-karpenter-instance-state"
  event_pattern = jsonencode({
    source      = ["aws.ec2"]
    detail-type = ["EC2 Instance State-change Notification"]
  })
}

resource "aws_cloudwatch_event_target" "karpenter_instance_state" {
  rule = aws_cloudwatch_event_rule.karpenter_instance_state.name
  arn  = aws_sqs_queue.karpenter.arn
}

resource "aws_cloudwatch_event_rule" "karpenter_spot_interruption" {
  name = "${var.ClusterBaseName}-karpenter-spot-interruption"
  event_pattern = jsonencode({
    source      = ["aws.ec2"]
    detail-type = ["EC2 Spot Instance Interruption Warning"]
  })
}

resource "aws_cloudwatch_event_target" "karpenter_spot_interruption" {
  rule = aws_cloudwatch_event_rule.karpenter_spot_interruption.name
  arn  = aws_sqs_queue.karpenter.arn
}

resource "aws_cloudwatch_event_rule" "karpenter_rebalance" {
  name = "${var.ClusterBaseName}-karpenter-rebalance"
  event_pattern = jsonencode({
    source      = ["aws.ec2"]
    detail-type = ["EC2 Instance Rebalance Recommendation"]
  })
}

resource "aws_cloudwatch_event_target" "karpenter_rebalance" {
  rule = aws_cloudwatch_event_rule.karpenter_rebalance.name
  arn  = aws_sqs_queue.karpenter.arn
}

resource "aws_cloudwatch_event_rule" "karpenter_health" {
  name = "${var.ClusterBaseName}-karpenter-health"
  event_pattern = jsonencode({
    source      = ["aws.health"]
    detail-type = ["AWS Health Event"]
  })
}

resource "aws_cloudwatch_event_target" "karpenter_health" {
  rule = aws_cloudwatch_event_rule.karpenter_health.name
  arn  = aws_sqs_queue.karpenter.arn
}

# Helm: Karpenter
resource "helm_release" "karpenter" {
  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  namespace  = local.karpenter_namespace

  values = [yamlencode({
    serviceAccount = {
      name = local.karpenter_sa_name
      annotations = {
        "eks.amazonaws.com/role-arn" = module.karpenter_irsa.iam_role_arn
      }
    }
    settings = {
      clusterName       = module.eks.cluster_name
      clusterEndpoint   = module.eks.cluster_endpoint
      interruptionQueue = aws_sqs_queue.karpenter.name
    }
    tolerations = [{
      key      = "CriticalAddonsOnly"
      operator = "Exists"
    }]
    affinity = {
      nodeAffinity = {
        requiredDuringSchedulingIgnoredDuringExecution = {
          nodeSelectorTerms = [{
            matchExpressions = [{
              key      = "tier"
              operator = "In"
              values   = ["system"]
            }]
          }]
        }
      }
    }
  })]

  depends_on = [module.eks]
}
