variable "key_vault_id" {
    type = string
    description = "value of key vault id"
  
}


variable "redis-cache-password-name" {
  type = string
  description = "value of redis cache password name"
  
}



variable "redis-cache-hostname-name" {
  type = string
  description = "value of redis cache hostname name"
  
}


variable "azurerm_redis_cache_primary_access_key" {
  description = "value of azurerm_redis_cache_primary_access_key"
}

variable "azurerm_redis_cache_hostname" {
  description = "value of azurerm_redis_cache_hostname"
}