data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "mykv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku
}

resource "azurerm_key_vault_access_policy" "aduser" {
  key_vault_id = azurerm_key_vault.mykv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = var.key_permissions_aduser
  secret_permissions = var.secret_permissions_aduser
  certificate_permissions = var.certificate_permissions_aduser
}


resource "azurerm_key_vault_access_policy" "az-tf-automation-app" {
  key_vault_id = azurerm_key_vault.mykv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.azuread_service_principal_az-tf-automation-app_object_id

  key_permissions = var.key_permissions_az-tf-automation-app
  secret_permissions = var.secret_permissions_az-tf-automation-app
  certificate_permissions = var.certificate_permissions_az-tf-automation-app
}