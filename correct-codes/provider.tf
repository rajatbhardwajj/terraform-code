terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.115.0"
    }
  }

  required_version = ">= 1.1"
}

provider "azurerm" {
  features {}
}
