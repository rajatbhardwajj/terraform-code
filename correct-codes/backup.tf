resource "azurerm_resource_group" "example" {
  name     = "tfex-recovery_vault"
  location = "West Europe"
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = "tfex-recovery-vault"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"
}

resource "azurerm_storage_account" "sa" {
  name                     = "rajatstorageacc"
  location                 = azurerm_resource_group.example.location
  resource_group_name      = azurerm_resource_group.example.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "example" {
  name                 = "example-share"
  storage_account_name = azurerm_storage_account.sa.name
  quota                = 1
}

resource "azurerm_backup_container_storage_account" "protection-container" {
  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  storage_account_id  = azurerm_storage_account.sa.id
}

resource "azurerm_backup_policy_file_share" "example" {
  name                = "tfex-recovery-vault-policy"
  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 10
  }
}

resource "azurerm_backup_protected_file_share" "share1" {
  resource_group_name       = azurerm_resource_group.example.name
  recovery_vault_name       = azurerm_recovery_services_vault.vault.name
  source_storage_account_id = azurerm_backup_container_storage_account.protection-container.storage_account_id
  source_file_share_name    = azurerm_storage_share.example.name
  backup_policy_id          = azurerm_backup_policy_file_share.example.id
}
