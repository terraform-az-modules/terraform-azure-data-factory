##-----------------------------------------------------------------------------
# Standard Tagging Module – Applies standard tags to all resources for traceability
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azure"
  version         = "1.0.0"
  name            = var.custom_name == null ? var.name : var.custom_name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

resource "azurerm_data_factory" "factory" {
  count                           = var.enabled ? 1 : 0
  name                            = replace(var.resource_position_prefix ? format("adf-%s", local.name) : format("%s-adf", local.name), "-", "")
  location                        = var.location
  resource_group_name             = var.resource_group_name
  public_network_enabled          = var.public_network_enabled
  managed_virtual_network_enabled = var.managed_virtual_network_enabled
  tags                            = module.labels.tags
  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" ? [join("", azurerm_user_assigned_identity.identity.*.id)] : null
    }
  }
  dynamic "github_configuration" {
    for_each = var.github_configuration != null ? [1] : []
    content {
      account_name    = var.github_configuration.account_name
      branch_name     = var.github_configuration.branch_name
      git_url         = var.github_configuration.git_url
      repository_name = var.github_configuration.repository_name
      root_folder     = var.github_configuration.root_folder
    }
  }
  dynamic "vsts_configuration" {
    for_each = var.vsts_configuration != null ? [1] : []
    content {
      account_name    = var.vsts_configuration.account_name
      branch_name     = var.vsts_configuration.branch_name
      project_name    = var.vsts_configuration.project_name
      repository_name = var.vsts_configuration.repository_name
      root_folder     = var.vsts_configuration.root_folder
      tenant_id       = var.vsts_configuration.tenant_id
    }
  }
  dynamic "global_parameter" {
    for_each = var.global_parameters != null ? var.global_parameters : []
    content {
      name  = global_parameter.value.name
      type  = global_parameter.value.type
      value = global_parameter.value.value
    }
  }
}
