########################
# EKS Cluster IAM Role
########################

# EKS 클러스터 IAM 역할
module "eks_cluster_role" {
  source = "../../modules/terraform-aws-iam-role"

  name = "${var.project_name}-eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
  policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
}

########################
# EKS Security Group
########################

# EKS Control Plane 추가 보안 그룹
module "eks_cp_sg" {
  source = "../../modules/terraform-aws-security-group"

  name        = "${var.project_name}-eks-cp-sg"
  vpc_id      = module.vpc.id
  description = "EKS Control Plane additional security group"

  ingress = {
    https = { from_port = "443", to_port = "443", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0", description = "Allow HTTPS from anywhere" }
  }
  egress = {
    all = { from_port = "0", to_port = "0", ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0", description = "Allow all outbound" }
  }
  tags = { Environment = "dev" }
}

########################
# EKS Cluster
########################

# EKS 클러스터 생성
module "eks" {
  source = "../../modules/terraform-aws-eks"

  name               = "${var.project_name}-eks"
  eks_version        = "1.35"
  role_arn           = module.eks_cluster_role.arn
  subnet_ids         = [module.app_subnets.subnets["${var.project_name}-app-a"].id, module.app_subnets.subnets["${var.project_name}-app-c"].id]
  security_group_ids = [module.eks_cp_sg.id]
  endpoint_public_access = true
  tags               = { Environment = "dev" }
}

########################
# EKS Node Group IAM Role
########################

# 워커 노드 IAM 역할
module "eks_node_role" {
  source = "../../modules/terraform-aws-iam-role"

  name = "${var.project_name}-eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
}

########################
# EKS Node Group SG
########################

# 워커 노드 보안 그룹
module "eks_node_sg" {
  source = "../../modules/terraform-aws-security-group"

  name        = "${var.project_name}-eks-node-sg"
  vpc_id      = module.vpc.id
  description = "EKS Worker Node security group"

  ingress = {
    all_vpc = { from_port = "0", to_port = "0", ip_protocol = "-1", cidr_ipv4 = var.vpc_block, description = "Allow all from VPC" }
    all_pod = { from_port = "0", to_port = "0", ip_protocol = "-1", cidr_ipv4 = "100.64.0.0/16", description = "Allow all from Pod CIDR" }
  }
  egress = {
    all = { from_port = "0", to_port = "0", ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0", description = "Allow all outbound" }
  }
  tags = { Environment = "dev" }
}

########################
# EKS Node AMI
########################

# AL2023 EKS Optimized AMI 조회
data "aws_ssm_parameter" "eks_ami" {
  name = "/aws/service/eks/optimized-ami/1.35/amazon-linux-2023/x86_64/standard/recommended/image_id"
}

########################
# EKS Node Launch Template
########################

# 워커 노드 Launch Template
module "eks_node_lt" {
  source = "../../modules/terraform-aws-launch-template"

  name                   = "${var.project_name}-eks-node-lt"
  image_id               = data.aws_ssm_parameter.eks_ami.value
  instance_type          = "t3.medium"
  vpc_security_group_ids = [module.eks_node_sg.id]

  lt_eks_vars = {
    eks_cluster_name                  = module.eks.name
    eks_cluster_endpoint              = module.eks.endpoint
    eks_cluster_certificate_authority = module.eks.certificate_authority
    eks_cluster_service_ipv4_cidr     = module.eks.service_ipv4_cidr
  }

  block_device_mappings = [{
    device_name = "/dev/xvda"
    volume_size = 30
    volume_type = "gp3"
  }]

  instance_tags = { Name = "${var.project_name}-eks-node", Environment = "dev" }
  volume_tags   = { Name = "${var.project_name}-eks-node", Environment = "dev" }
  tags          = { Environment = "dev" }
}

########################
# EKS Managed Node Group
########################

# 워커 노드 그룹
module "eks_ng" {
  source = "../../modules/terraform-aws-eks-ng"

  cluster_name    = module.eks.name
  node_group_name = "${var.project_name}-eks-ng-1"
  node_role_arn   = module.eks_node_role.arn
  subnet_ids      = [module.app_subnets.subnets["${var.project_name}-app-a"].id, module.app_subnets.subnets["${var.project_name}-app-c"].id]

  min_size     = 1
  max_size     = 3
  desired_size = 1

  launch_template_name    = module.eks_node_lt.name
  launch_template_version = module.eks_node_lt.latest_version

  update_config = { max_unavailable = 1 }

  tags = { Environment = "dev" }

  # Custom Networking(ENIConfig)이 먼저 적용된 후 노드가 뜨도록
  depends_on = [module.eks_addon_pre_node, kubernetes_manifest.eniconfig_az1, kubernetes_manifest.eniconfig_az3]
}
