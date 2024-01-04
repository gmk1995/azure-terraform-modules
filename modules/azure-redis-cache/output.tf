output "azurerm_redis_cache_primary_access_key" {
  value = azurerm_redis_cache.myrediscache.primary_access_key
}

output "azurerm_redis_cache_hostname" {
  value = azurerm_redis_cache.myrediscache.hostname
}