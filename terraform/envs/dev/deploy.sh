#!/bin/bash
set -e

REGION="ap-northeast-2"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TF="terraform -chdir=$SCRIPT_DIR"
PROJECT_NAME="smlim-gitops-dev"

# 이전 destroy에서 남은 로그 그룹 정리
echo "기존 로그 그룹 정리..."
aws logs delete-log-group --region "$REGION" \
  --log-group-name "/aws/eks/${PROJECT_NAME}-eks/cluster" 2>/dev/null || true

echo "=========================================="
echo "1단계: VPC + 서브넷 + NAT + 라우트 테이블"
echo "=========================================="
$TF apply -auto-approve \
  -target=module.vpc \
  -target=module.pub_subnets \
  -target=module.app_subnets \
  -target=module.db_subnets \
  -target=module.pod_subnets \
  -target=module.natgw \
  -target=module.pub_rt \
  -target=module.app_rt \
  -target=module.db_rt \
  -target=module.pod_rt

echo "=========================================="
echo "2단계: IAM + SG + EKS 클러스터"
echo "=========================================="
$TF apply -auto-approve \
  -target=module.eks_cluster_role \
  -target=module.eks_cp_sg \
  -target=module.eks_node_role \
  -target=module.eks_node_sg \
  -target=module.eks

# kubeconfig 설정
CLUSTER_NAME=$($TF output -raw eks_cluster_name)
aws eks update-kubeconfig --region "$REGION" --name "$CLUSTER_NAME"

echo "=========================================="
echo "3단계: VPC CNI + ENIConfig (노드 전)"
echo "=========================================="
$TF apply -auto-approve \
  -target=module.eks_addon_pre_node \
  -target=kubernetes_manifest.eniconfig_az1 \
  -target=kubernetes_manifest.eniconfig_az3

echo "=========================================="
echo "4단계: Launch Template + 노드그룹"
echo "=========================================="
$TF apply -auto-approve \
  -target=data.aws_ssm_parameter.eks_ami \
  -target=module.eks_node_lt \
  -target=module.eks_ng

# 노드 Ready 대기
echo "노드 Ready 대기 중..."
kubectl wait --for=condition=Ready nodes --all --timeout=600s

echo "=========================================="
echo "5단계: CoreDNS + kube-proxy (노드 후)"
echo "=========================================="
$TF apply -auto-approve \
  -target=module.eks_addon_post_node

echo "=========================================="
echo "6단계: Karpenter 인프라"
echo "=========================================="
$TF apply -auto-approve \
  -target=aws_iam_role.karpenter_controller \
  -target=aws_iam_role_policy.karpenter_controller \
  -target=aws_eks_pod_identity_association.karpenter \
  -target=aws_iam_role.karpenter_node \
  -target=aws_iam_role_policy_attachment.karpenter_node_policies \
  -target=aws_eks_access_entry.karpenter_node \
  -target=aws_sqs_queue.karpenter \
  -target=aws_sqs_queue_policy.karpenter \
  -target=aws_cloudwatch_event_rule.karpenter_instance_state \
  -target=aws_cloudwatch_event_target.karpenter_instance_state \
  -target=aws_cloudwatch_event_rule.karpenter_spot_interruption \
  -target=aws_cloudwatch_event_target.karpenter_spot_interruption \
  -target=aws_cloudwatch_event_rule.karpenter_rebalance \
  -target=aws_cloudwatch_event_target.karpenter_rebalance \
  -target=aws_cloudwatch_event_rule.karpenter_health \
  -target=aws_cloudwatch_event_target.karpenter_health

echo "=========================================="
echo "7단계: FluxCD Helm 설치"
echo "=========================================="
$TF apply -auto-approve \
  -target=helm_release.flux

echo "=========================================="
echo "8단계: FluxCD Bootstrap (CRD 설치 후)"
echo "=========================================="
$TF apply -auto-approve \
  -target=kubernetes_secret.flux_git_auth \
  -target=kubernetes_manifest.flux_git_repo \
  -target=kubernetes_manifest.flux_kustomization

echo "=========================================="
echo "최종 동기화 (drift 방지)"
echo "=========================================="
$TF apply -auto-approve

echo "=========================================="
echo "배포 완료"
echo "=========================================="
kubectl get nodes -o wide
kubectl get pods -A
