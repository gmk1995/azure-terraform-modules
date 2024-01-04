variable "azurerm_resource_group" {
    type = string
    description = "The name of the resource group in which the Redis Cache should be created"
  
}

variable "location" {
    type = string
    description = "The Azure Region in which all resources in this example should be created."
  
}

variable "azurerm_redis_cache_name" {
  type = string
  description = "The name of the Redis Cache"
}

variable "redis_capacity" {
  type = number
  description = "The Redis capacity of Redis Cache to use"
}

variable "redis_family" {
  type = string
  description = "The Redis family of Redis Cache to use"
}
variable "sku" {
  type = string
  description = "The SKU of Redis Cache to use"
}

variable "redis_enable_non_ssl_port" {
  type = bool
  description = "The Redis enable non ssl port of Redis Cache to use"
}

variable "redis_minimum_tls_version" {
  type = number
  description = "The Redis minimum tls version of Redis Cache to use"
}
