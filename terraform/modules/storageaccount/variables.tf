variable "ResourceGroupName" {
    description = "Name of the resource group in which to create the Storage Account"
    type        = string
}

variable "ResourceGroupLocation" {
    description = "Location of the resource group in which to create the Storage Account"
    type        = string
    default     = "canadacentral"
}

variable "StorageAccountName" {
  type        = string
  description = "The name of the Storage Account."
}

variable "StorageFileShareNames" {
  type        = list(string)
  description = "The name of the Storage File Share."
  default     = []
}