# Create virtual network
resource "azurerm_virtual_network" "dockernetwork" {
  name                = var.network_name
  address_space       = [var.network_cidr]
  location            = azurerm_resource_group.dockercoderartinginx.location
  resource_group_name = azurerm_resource_group.dockercoderartinginx.name

  tags = {
    environment = var.env_tag
    owner       = var.owner_tag
  }
}

# Create subnet
resource "azurerm_subnet" "dockersubnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.dockercoderartinginx.name
  virtual_network_name = azurerm_virtual_network.dockernetwork.name
  address_prefixes     = [var.subnet_cidr]
}

# Create public IPs
resource "azurerm_public_ip" "dockerpip" {
  name                = var.dockerpip_name
  location            = azurerm_resource_group.dockercoderartinginx.location
  resource_group_name = azurerm_resource_group.dockercoderartinginx.name
  allocation_method   = "Dynamic"
  domain_name_label   = var.fqdn

  tags = {
    environment = var.env_tag
    owner       = var.owner_tag
  }
}
