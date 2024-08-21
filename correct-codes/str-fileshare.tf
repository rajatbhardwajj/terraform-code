
# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

# Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "rajatstoracc" #Must be between 3 and 24 characters and use only lowercase letters and numbers.
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"  # Locally redundant storage

  tags = {
    environment = "example"
  }
}

# File Share
resource "azurerm_storage_share" "example" {
  name                 = "example-fileshare"  # Must be between 3 and 63 characters and use only lowercase letters and numbers.
  storage_account_name = azurerm_storage_account.example.name
  quota                = 50  # Quota in GB
}

