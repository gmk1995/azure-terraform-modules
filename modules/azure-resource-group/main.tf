resource "azurerm_resource_group" "myrg" {
  name     = var.azurerm_resource_group
  location = var.location
}