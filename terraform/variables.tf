#Variables used by terraform to populate from tfvars file for all infrastructure resources
variable "ResourceGroupName" {
    description = "Name of the resource group in which to create the resources"
    type        = string
}

variable "ResourceGroupLocation" {
    description = "Location of the resource group in which to create the resources"
    type        = string
    default     = "canadacentral"
}

variable "ContainerRegistryName" {
    description = "Name of the container registry"
    type        = string
}

variable "ContainerRegistryResourceGroupName" {
    description = "Name of the resource group in which the container registry is located"
    type        = string
}

# Variable to store key vault name
variable "KeyVaultName" {
    description = "Name of the key vault"
    type        = string
}

variable "StorageAccountName" {
    description = "Name of the storage account"
    type        = string
}

variable "AppServiceName" {
    description = "The name of the App Service"
    type        = string
}

variable "AppServiceAppSettings" {
    type        = map(string)
    description = "The app settings for the Key Vault."
    default     = {}
}

variable "AppServiceVolumeMounts" {
  type        = list(object({
    name               = string
    shareName          = string
    mountPath          = string
  }))

  description = "The volume mounts"
  default = []
}

variable "SiteContainerName" {
    description = "The name of the container"
    type        = string
}

variable "SiteContainerImage" {
    description = "The image of the container"
    type        = string
}

variable "SiteContainerPort" {
    description = "The port of the container"
    type        = number
    default     = 8080
}



variable "SiteContainerEnvironmentVariables" {
    type        = list(object({
        name  = string
        value = string
    }))
    description = "The environment variables for the container."
    default     = []
}

variable "SiteContainerVolumeMounts" {
    type        = list(object({
        containerMountPath = string
        data               = string
        readOnly           = bool
        volumeSubPath      = string
    }))
    description = "The volume mounts for the container."
    default     = []
}

