//Create Storage Account
resource "azurerm_storage_account" "storageaccount" {
  name                     = var.StorageAccountName
  resource_group_name      = var.ResourceGroupName
  location                 = var.ResourceGroupLocation
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # public_network_access_enabled = false //TODO: Uncomment later

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

//Create File Share
resource "azurerm_storage_share" "fileshare" {
  for_each = toset(var.StorageFileShareNames)
  
  name                 = each.key
  storage_account_name = azurerm_storage_account.storageaccount.name
  quota                = 100
}