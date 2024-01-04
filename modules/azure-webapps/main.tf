resource "azurerm_app_service_plan" "plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.kind       # For containers
  reserved            = var.reserved   # Required for containers

  sku {
    tier = var.sku_tier  # Adjust as needed
    size = var.sku_size  # Adjust as needed
  }
}

resource "azurerm_app_service" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version = var.linux_fx_version  # Replace with your container image details
  }

  app_settings = {
   for key, value in var.app_settings :
    key => value
  }

  identity {
        type = var.identity
    }   
}


resource "azurerm_role_assignment" "acr_pull_role_assignment" {
  scope                = var.private_registry_id # Replace with your ACR resource ID
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_app_service.app.identity[0].principal_id
  skip_service_principal_aad_check = true
}

