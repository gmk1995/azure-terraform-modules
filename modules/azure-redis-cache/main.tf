# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "myrediscache" {
  name                = var.azurerm_redis_cache_name
  location            = var.location
  resource_group_name = var.azurerm_resource_group
  capacity            = var.redis_capacity
  family              = var.redis_family
  sku_name            = var.sku
  enable_non_ssl_port = var.redis_enable_non_ssl_port
  minimum_tls_version = var.redis_minimum_tls_version

  redis_configuration {
  }
}