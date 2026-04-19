

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "lbdemovmss"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard_DC1ds_v3"
  instances           = 3
  admin_username      = "adminuservmss"

  custom_data = base64encode(file("script.sh"))

  admin_ssh_key {
    username   = "adminuservmss"
    public_key = data.azurerm_key_vault_secret.ssh.value
  }

source_image_reference {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-confidential-vm-focal"
  sku       = "20_04-lts-cvm"
  version   = "latest"
}

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${local.name_prefix}-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.app.id

 load_balancer_backend_address_pool_ids = [
        azurerm_lb_backend_address_pool.bepool.id
        ]
    }
  }
    # Ignore changes to the instances property, so that the VMSS is not recreated when the number of instances is changed
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      instances
    ]
  }
}