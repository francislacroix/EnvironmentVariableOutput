# Get the current config
data "azurerm_client_config" "current" {}

# Create Azure key Vault
resource "azurerm_key_vault" "keyvault" {
  name                       = var.KeyVaultName
  resource_group_name        = var.ResourceGroupName
  location                   = var.ResourceGroupLocation

  tenant_id                  = data.azurerm_client_config.current.tenant_id

  purge_protection_enabled   = false

  enable_rbac_authorization = true

  public_network_access_enabled = true

  sku_name = "standard"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

  