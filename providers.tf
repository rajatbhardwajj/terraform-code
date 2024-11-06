terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.8.0"
    }
  }
required_version = "1.9.7"

}
provider "azurerm" {
  features {}

}
