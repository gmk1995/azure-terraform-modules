resource "azurerm_key_vault_secret" "redis-cache-password" {
  name         = var.redis-cache-password-name
  value        = var.azurerm_redis_cache_primary_access_key
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "redis-cache-hostname" {
  name         = var.redis-cache-hostname-name
  value        = var.azurerm_redis_cache_hostname
  key_vault_id = var.key_vault_id
}