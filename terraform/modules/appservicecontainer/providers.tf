terraform {
  required_version = ">=1.8"

  required_providers {
    azapi = {
      source = "azure/azapi"
      version = "~>2.0.1"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.106"
    }
  }
}

provider "azurerm" {
  features {}
}