########################
# Flux CD
########################

resource "helm_release" "flux" {
  name             = "flux2"
  repository       = "https://fluxcd-community.github.io/helm-charts"
  chart            = "flux2"
  namespace        = "flux-system"
  create_namespace = true

  values = [yamlencode({
    cli = {
      nodeSelector = {
        tier = "system"
      }
      tolerations = [{
        key      = "CriticalAddonsOnly"
        operator = "Exists"
        effect   = "NoSchedule"
      }]
    }
    helmController = {
      nodeSelector = {
        tier = "system"
      }
      tolerations = [{
        key      = "CriticalAddonsOnly"
        operator = "Exists"
        effect   = "NoSchedule"
      }]
    }
    kustomizeController = {
      nodeSelector = {
        tier = "system"
      }
      tolerations = [{
        key      = "CriticalAddonsOnly"
        operator = "Exists"
        effect   = "NoSchedule"
      }]
    }
    sourceController = {
      nodeSelector = {
        tier = "system"
      }
      tolerations = [{
        key      = "CriticalAddonsOnly"
        operator = "Exists"
        effect   = "NoSchedule"
      }]
    }
    notificationController = {
      nodeSelector = {
        tier = "system"
      }
      tolerations = [{
        key      = "CriticalAddonsOnly"
        operator = "Exists"
        effect   = "NoSchedule"
      }]
    }
    imageAutomationController = {
      nodeSelector = {
        tier = "system"
      }
      tolerations = [{
        key      = "CriticalAddonsOnly"
        operator = "Exists"
        effect   = "NoSchedule"
      }]
    }
    imageReflectionController = {
      nodeSelector = {
        tier = "system"
      }
      tolerations = [{
        key      = "CriticalAddonsOnly"
        operator = "Exists"
        effect   = "NoSchedule"
      }]
    }
  })]

  depends_on = [module.eks]
}

# Git repo 연동 — GITHUB_TOKEN을 Secret으로 생성
resource "kubernetes_secret" "flux_git_auth" {
  metadata {
    name      = "flux-git-auth"
    namespace = "flux-system"
  }

  data = {
    username = "git"
    password = var.github_token
  }

  depends_on = [helm_release.flux]
}

# GitRepository: Flux가 watch할 repo
resource "kubernetes_manifest" "flux_git_repo" {
  manifest = {
    apiVersion = "source.toolkit.fluxcd.io/v1"
    kind       = "GitRepository"
    metadata = {
      name      = "flux-system"
      namespace = "flux-system"
    }
    spec = {
      interval = "1m"
      url      = var.flux_git_url
      ref = {
        branch = var.flux_git_branch
      }
      secretRef = {
        name = "flux-git-auth"
      }
    }
  }

  depends_on = [helm_release.flux, kubernetes_secret.flux_git_auth]
}

# Kustomization: repo 내 특정 경로를 클러스터에 동기화
resource "kubernetes_manifest" "flux_kustomization" {
  manifest = {
    apiVersion = "kustomize.toolkit.fluxcd.io/v1"
    kind       = "Kustomization"
    metadata = {
      name      = "flux-system"
      namespace = "flux-system"
    }
    spec = {
      interval = "1m"
      path     = var.flux_git_path
      prune    = true
      sourceRef = {
        kind = "GitRepository"
        name = "flux-system"
      }
    }
  }

  depends_on = [kubernetes_manifest.flux_git_repo]
}
