####################################################################
# Module Name : EKS Cluster Addon
# Module Desc : EKS Cluster Addon을 생성합니다.
####################################################################

##################################
# EKS Cluster Addon
##################################
resource "aws_eks_addon" "this" {
  for_each = { for k, v in var.addon : v.addon_name => v }

  cluster_name                = var.cluster_name
  addon_name                  = each.value.addon_name
  addon_version               = try(each.value.addon_version != "" ? each.value.addon_version : var.addon_versions[each.value.name], var.addon_versions[each.value.name])
  service_account_role_arn    = try(each.value.service_account_role_arn, null)
  configuration_values        = try(length(each.value.configuration_values) > 0, false) ? each.value.configuration_values : null
  resolve_conflicts_on_create = try(each.value.resolve_conflicts_on_create, "OVERWRITE")
  resolve_conflicts_on_update = try(each.value.resolve_conflicts_on_update, "OVERWRITE")
}
