resource "azurerm_container_group" "myacg" {
  name                = var.acg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = var.acg_ip_address_type
  dns_name_label      = var.acg_dns_name_label
  os_type             = var.acg_os_type

  image_registry_credential {
    server   = var.registry_login_server
    username = var.admin_username
    password = var.admin_password
  }

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = var.container_cpu
    memory = var.container_memory

    environment_variables = {
      for env_var in var.container_environment_variables :
    env_var.name => env_var.value
    }
    ports {
      port     = var.container_ports[0].port
      protocol = var.container_ports[0].protocol
    }
  }
}
