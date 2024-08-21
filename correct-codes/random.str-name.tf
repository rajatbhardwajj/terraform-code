resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

# Generate a random 5-character string
resource "random_string" "random_suffix" {
  length  = 5
  special = false
  upper   = false
}

# Create an Azure Storage Account with a random suffix
resource "azurerm_storage_account" "example" {
  name                     = "rajat${random_string.random_suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Terraform Demo"
  }
}

