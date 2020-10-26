# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "dockercoderartinginx" {
  name     = var.rg_name
  location = var.region

  tags = {
    environment = var.env_tag
    owner       = var.owner_tag
  }
}
