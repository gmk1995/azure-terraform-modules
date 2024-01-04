resource "azurerm_log_analytics_workspace" "lawspace" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
}

resource "azurerm_container_app_environment" "cae" {
  name                       = var.azurerm_container_app_environment_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.lawspace.id
}


resource "azurerm_container_app" "app" {
  name                         = var.azurerm_container_app_name
  container_app_environment_id = azurerm_container_app_environment.cae.id
  resource_group_name          = var.resource_group_name
  revision_mode                = var.revision_mode

  lifecycle {
    ignore_changes = [
      template.0.container[0].image
    ]
  }

  secret {
    name  = var.secret_name
    value = var.password
  }

  registry {
    server               = var.server
    username             = var.username
    password_secret_name = var.secret_name
  }
    ingress {
    external_enabled = var.ingress_enabled
    target_port      = var.target_port
    traffic_weight {
      percentage      = var.percentage
      latest_revision = var.latest_revision
    }
  }
  template {
    container {
      name   = var.container_name
      image  = var.container_image
      cpu    = var.cpu
      memory = var.memory

      env {
        name        = var.environment_variables_name
        value       = var.environment_variables_value
      }
    }
    
  }
  identity {
    type = var.identity
  }
}