variable "ResourceGroupName" {
    description = "Name of the resource group in which to create the Key Vault"
    type        = string
}

variable "ResourceGroupLocation" {
    description = "Location of the resource group in which to create the Key Vault"
    type        = string
    default     = "canadacentral"
}

variable "KeyVaultName" {
  type        = string
  description = "The name of the Key Vault."
}


