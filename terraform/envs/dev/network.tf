########################
# VPC
########################

# VPC 생성
module "vpc" {
  source = "../../modules/terraform-aws-vpc-core"

  name                 = "${var.project_name}-vpc"
  cidr_block           = var.vpc_block
  secondary_cidr_block = ["100.64.0.0/16"]
  igw_enable           = true
  vpc_flowlog_enable   = false
  tags                 = { Environment = "dev" }
}

########################
# Subnets
########################

# Public 서브넷
module "pub_subnets" {
  source = "../../modules/terraform-aws-subnets"

  vpc_id = module.vpc.id
  subnets = [
    { name = "${var.project_name}-pub-a", availability_zone_id = "apne2-az1", cidr_block = "10.140.32.0/27", map_public_ip_on_launch = true, tags = { "kubernetes.io/role/elb" = "1" } },
    { name = "${var.project_name}-pub-c", availability_zone_id = "apne2-az3", cidr_block = "10.140.32.32/27", map_public_ip_on_launch = true, tags = { "kubernetes.io/role/elb" = "1" } },
  ]
}

# App 서브넷
module "app_subnets" {
  source = "../../modules/terraform-aws-subnets"

  vpc_id = module.vpc.id
  subnets = [
    { name = "${var.project_name}-app-a", availability_zone_id = "apne2-az1", cidr_block = "10.140.32.64/26", tags = { "kubernetes.io/role/internal-elb" = "1" } },
    { name = "${var.project_name}-app-c", availability_zone_id = "apne2-az3", cidr_block = "10.140.32.128/26", tags = { "kubernetes.io/role/internal-elb" = "1" } },
  ]
}

# DB 서브넷
module "db_subnets" {
  source = "../../modules/terraform-aws-subnets"

  vpc_id = module.vpc.id
  subnets = [
    { name = "${var.project_name}-db-a", availability_zone_id = "apne2-az1", cidr_block = "10.140.32.192/27" },
    { name = "${var.project_name}-db-c", availability_zone_id = "apne2-az3", cidr_block = "10.140.32.224/27" },
  ]
}

# Pod 서브넷 (Secondary CIDR)
module "pod_subnets" {
  source = "../../modules/terraform-aws-subnets"

  vpc_id = module.vpc.id
  subnets = [
    { name = "${var.project_name}-pod-a-1", availability_zone_id = "apne2-az1", cidr_block = "100.64.0.0/19" },
    { name = "${var.project_name}-pod-a-2", availability_zone_id = "apne2-az1", cidr_block = "100.64.32.0/19" },
    { name = "${var.project_name}-pod-a-3", availability_zone_id = "apne2-az1", cidr_block = "100.64.64.0/19" },
    { name = "${var.project_name}-pod-c-1", availability_zone_id = "apne2-az3", cidr_block = "100.64.96.0/19" },
    { name = "${var.project_name}-pod-c-2", availability_zone_id = "apne2-az3", cidr_block = "100.64.128.0/19" },
    { name = "${var.project_name}-pod-c-3", availability_zone_id = "apne2-az3", cidr_block = "100.64.160.0/19" },
  ]

  # destroy 시 노드그룹이 먼저 삭제되어야 ENI가 정리되고 서브넷 삭제 가능
  depends_on = [module.vpc]
}

########################
# NAT Gateway
########################

# NAT Gateway 생성
module "natgw" {
  source = "../../modules/terraform-aws-natgateway"

  natgateway = [
    { name = "${var.project_name}-natgw-a", subnet_id = module.pub_subnets.subnets["${var.project_name}-pub-a"].id, connectivity_type = "public" },
  ]
  tags = { Environment = "dev" }
}

########################
# Route Tables
########################

# Public 라우트 테이블
module "pub_rt" {
  source = "../../modules/terraform-aws-route-table"

  vpc_id     = module.vpc.id
  name       = "${var.project_name}-pub-rt"
  subnet_ids = [module.pub_subnets.subnets["${var.project_name}-pub-a"].id, module.pub_subnets.subnets["${var.project_name}-pub-c"].id]
  routes     = [{ destination_cidr_block = "0.0.0.0/0", gateway_id = module.vpc.igw_id }]
}

# App 라우트 테이블
module "app_rt" {
  source = "../../modules/terraform-aws-route-table"

  vpc_id     = module.vpc.id
  name       = "${var.project_name}-app-rt"
  subnet_ids = [module.app_subnets.subnets["${var.project_name}-app-a"].id, module.app_subnets.subnets["${var.project_name}-app-c"].id]
  routes     = [{ destination_cidr_block = "0.0.0.0/0", nat_gateway_id = module.natgw.natgateways["${var.project_name}-natgw-a"].id }]
}

# DB 라우트 테이블
module "db_rt" {
  source = "../../modules/terraform-aws-route-table"

  vpc_id     = module.vpc.id
  name       = "${var.project_name}-db-rt"
  subnet_ids = [module.db_subnets.subnets["${var.project_name}-db-a"].id, module.db_subnets.subnets["${var.project_name}-db-c"].id]
  routes     = []
}

# Pod 라우트 테이블
module "pod_rt" {
  source = "../../modules/terraform-aws-route-table"

  vpc_id     = module.vpc.id
  name       = "${var.project_name}-pod-rt"
  subnet_ids = [for s in values(module.pod_subnets.subnets) : s.id]
  routes     = [{ destination_cidr_block = "0.0.0.0/0", nat_gateway_id = module.natgw.natgateways["${var.project_name}-natgw-a"].id }]
}
