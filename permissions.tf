##-----------------------------------------------------------------------------
## Permissions, Roles, and Policies
##-----------------------------------------------------------------------------
resource "azurerm_user_assigned_identity" "identity" {
  count               = var.enabled && var.cmk_encryption_enabled ? 1 : 0
  location            = var.location
  name                = format("midd-adf-%s", module.labels.id)
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "identity_assigned" {
  depends_on           = [azurerm_user_assigned_identity.identity]
  count                = var.enabled && var.cmk_encryption_enabled ? 1 : 0
  principal_id         = join("", azurerm_user_assigned_identity.identity.*.principal_id)
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Crypto Service Encryption User"
}