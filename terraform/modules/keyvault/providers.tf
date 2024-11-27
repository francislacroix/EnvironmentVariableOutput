terraform {
  required_version = ">=1.8"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.106"
    }
  }
}

provider "azurerm" {
  features {}
}