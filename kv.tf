resource "azurerm_key_vault" "kvlab43" {
  name                = "${local.name_prefix}-kvlab44"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = "2c3db97c-7da7-4c24-8e4f-0f0dfe0b0dbb"
  sku_name            = "standard"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "access_policy" {
  key_vault_id = azurerm_key_vault.kvlab43.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Purge", "Recover", "Restore"
  ]
}

resource "azurerm_key_vault_secret" "ssh_key" {
  name         = "vmss-ssh-key"
  value        = file("C:\\privatekey\\vmsshkey.pub")
  key_vault_id = azurerm_key_vault.kvlab43.id
depends_on = [ azurerm_key_vault.kvlab43 ]

}

data "azurerm_key_vault_secret" "ssh" {
  name         = azurerm_key_vault_secret.ssh_key.name
  key_vault_id = azurerm_key_vault.kvlab43.id
}
