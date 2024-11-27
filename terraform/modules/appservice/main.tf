# Create App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "${var.AppServiceName}-plan"
  resource_group_name = var.ResourceGroupName
  location            = var.ResourceGroupLocation
  os_type             = "Linux"
  sku_name            = "P0v3"
}

# Create App Service
resource "azurerm_linux_web_app" "appservice" {
  name                = var.AppServiceName
  resource_group_name = var.ResourceGroupName
  location            = var.ResourceGroupLocation

  service_plan_id     = azurerm_service_plan.appserviceplan.id

  https_only = true
  public_network_access_enabled = true

  identity {
    type = "SystemAssigned"
  }

  app_settings = var.AppServiceAppSettings

  site_config {}

  dynamic "storage_account" {
    for_each = var.VolumeMounts
    content {
      name = storage_account.value["name"]
      account_name = storage_account.value["storageAccountName"]
      access_key = storage_account.value["storageAccountKey"]
      share_name = storage_account.value["shareName"]
      type = storage_account.value["shareType"]
      mount_path = storage_account.value["mountPath"]
    }
  }
}

resource "azapi_update_resource" "container_app_api" {
  type        = "Microsoft.Web/sites@2023-12-01"
  resource_id = azurerm_linux_web_app.appservice.id

  body = {
    properties = {
      siteConfig = {
        linuxFxVersion = "sitecontainers"
      }
    }
  }

  lifecycle {
    replace_triggered_by = [ azurerm_linux_web_app.appservice ]
  }
}

resource "azurerm_role_assignment" "acrReaderAccess" {
  scope                = var.ContainerRegistryID
  role_definition_name = "Reader"
  principal_id         = azurerm_linux_web_app.appservice.identity[0].principal_id
}

resource "azurerm_role_assignment" "acrPullAccess" {
  scope                = var.ContainerRegistryID
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.appservice.identity[0].principal_id
}

resource "azurerm_role_assignment" "keyVaultReaderAccess" {
  scope                = var.KeyVaultID
  role_definition_name = "Reader"
  principal_id         = azurerm_linux_web_app.appservice.identity[0].principal_id
}

resource "azurerm_role_assignment" "keyVaultSecretAccess" {
  scope                = var.KeyVaultID
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_web_app.appservice.identity[0].principal_id
}