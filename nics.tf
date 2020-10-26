resource "azurerm_network_interface" "dockernic" {
  name                = "dockerNIC"
  location            = azurerm_resource_group.dockercoderartinginx.location
  resource_group_name = azurerm_resource_group.dockercoderartinginx.name

  ip_configuration {
    name                          = "docker-NicConfiguration"
    subnet_id                     = azurerm_subnet.dockersubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dockerpip.id
  }

  tags = {
    environment = var.env_tag
    owner       = var.owner_tag
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "jointhem" {
  network_interface_id      = azurerm_network_interface.dockernic.id
  network_security_group_id = azurerm_network_security_group.dockersecuitygr.id
}
