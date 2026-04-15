#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TF="terraform -chdir=$SCRIPT_DIR"

echo "=========================================="
echo "1단계: FluxCD 삭제 (Karpenter Helm 포함)"
echo "=========================================="
$TF destroy -auto-approve \
  -target=kubernetes_manifest.flux_kustomization \
  -target=kubernetes_manifest.flux_git_repo \
  -target=kubernetes_secret.flux_git_auth \
  -target=helm_release.flux || true

echo "=========================================="
echo "2단계: 노드그룹 삭제 (ENI 정리를 위해 먼저)"
echo "=========================================="
$TF destroy -auto-approve \
  -target=module.eks_ng \
  -target=module.eks_node_lt || true

echo "노드 종료 대기 중 (60초)..."
sleep 60

echo "=========================================="
echo "3단계: ENIConfig + Addon 삭제"
echo "=========================================="
$TF destroy -auto-approve \
  -target=kubernetes_manifest.eniconfig_az1 \
  -target=kubernetes_manifest.eniconfig_az3 \
  -target=module.eks_addon || true

echo "=========================================="
echo "4단계: 나머지 전체 삭제"
echo "=========================================="
$TF destroy -auto-approve

echo "=========================================="
echo "삭제 완료"
echo "=========================================="
