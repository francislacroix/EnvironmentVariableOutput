variable "ResourceGroupName" {
    description = "Name of the resource group in which to create the Key Vault"
    type        = string
}

variable "ResourceGroupLocation" {
    description = "Location of the resource group in which to create the Key Vault"
    type        = string
    default     = "canadacentral"
}

variable "AppServiceName" {
  type        = string
  description = "The name of the Key Vault."
}

variable "AppServiceAppSettings" {
  type        = map(string)
  description = "The app settings for the Key Vault."
  default     = {}
}

variable "ContainerRegistryID" {
    description = "Name of the subnet to attach the Key Vault"
    type        = string
}

variable "KeyVaultID" {
    description = "Name of the subnet to attach the Key Vault"
    type        = string
}

variable "VolumeMounts" {
  type        = list(object({
    name               = string
    storageAccountName = string
    storageAccountKey  = string
    shareName          = string
    shareType          = string
    mountPath          = string
  }))

  description = "The volume mounts"
  default = []
}






