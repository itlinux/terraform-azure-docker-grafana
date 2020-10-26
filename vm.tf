
# Create virtual machine ready for docker. This is CentOS
resource "azurerm_linux_virtual_machine" "linuxbox" {
  name                  = var.linux_vm_name
  location              = azurerm_resource_group.dockercoderartinginx.location
  resource_group_name   = azurerm_resource_group.dockercoderartinginx.name
  network_interface_ids = [azurerm_network_interface.dockernic.id]
  size                  = var.machine_type_selected

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }

  computer_name                   = "linuxbox"
  admin_username                  = var.ssh_user
  disable_password_authentication = true


  admin_ssh_key {
    username   = var.ssh_user
    public_key = tls_private_key.docker_ssh.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.dockerstorage.primary_blob_endpoint
  }

  tags = {
    environment = var.env_tag
    owner       = var.owner_tag
  }
}
