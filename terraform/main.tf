# Create the resource group that will contain the app infrustructure resources
resource "azurerm_resource_group" "resource_group" {
  name     = var.ResourceGroupName
  location = var.ResourceGroupLocation
}

# Get a reference to the Azure Container Registry
data "azurerm_container_registry" "container_registry" {
  name                = var.ContainerRegistryName
  resource_group_name = var.ContainerRegistryResourceGroupName
}

# Create the KeyVault
module "KeyVault" {
  source = "./modules/keyvault"

  ResourceGroupName               = azurerm_resource_group.resource_group.name
  ResourceGroupLocation           = azurerm_resource_group.resource_group.location
  KeyVaultName                    = var.KeyVaultName
}

#Call to Storage Account module
module "StorageAcount" {
  source = "./modules/storageaccount"

  ResourceGroupName               = azurerm_resource_group.resource_group.name
  ResourceGroupLocation           = azurerm_resource_group.resource_group.location
  StorageAccountName              = var.StorageAccountName
  StorageFileShareNames           = [for volumeMount in var.AppServiceVolumeMounts : volumeMount.shareName]
}

# Create the App Service
module "AppService" {
  source = "./modules/appservice"

  ResourceGroupName               = azurerm_resource_group.resource_group.name
  ResourceGroupLocation           = azurerm_resource_group.resource_group.location
  AppServiceName                  = var.AppServiceName
  AppServiceAppSettings           = var.AppServiceAppSettings
  ContainerRegistryID             = data.azurerm_container_registry.container_registry.id
  KeyVaultID                      = module.KeyVault.KeyVaultID
  VolumeMounts                    = [for volumeMount in var.AppServiceVolumeMounts : {
    name = volumeMount.name
    storageAccountName = var.StorageAccountName
    storageAccountKey = module.StorageAcount.StorageAccountKey
    shareName = volumeMount.shareName
    shareType = "AzureFiles"
    mountPath = volumeMount.mountPath
  }]
}

# Create the container registry
module "SiteContainer" {
  source = "./modules/appservicecontainer"

  AppServiceID                    = module.AppService.AppServiceID
  ContainerName                   = var.SiteContainerName
  ContainerImage                  = var.SiteContainerImage
  IsMainContainer                 = true
  TargetPort                      = var.SiteContainerPort
  EnvironmentVaribles             = var.SiteContainerEnvironmentVariables
  volumeMounts                    = var.SiteContainerVolumeMounts
}