
  resource "azurerm_resource_group" "strg" {
  name     = "rg-tfstate"
  location = "East US"
}

resource "azurerm_storage_account" "storage" {
  name                     = "tfstate1234543"
  resource_group_name      = azurerm_resource_group.strg.name
  location                 = azurerm_resource_group.strg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [ azurerm_resource_group.strg ]
}

resource "azurerm_storage_container" "container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"

  depends_on = [ azurerm_storage_account.storage ]
}