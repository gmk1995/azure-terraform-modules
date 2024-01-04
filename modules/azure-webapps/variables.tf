variable "service_plan_name" {
    type = string
    description = "App Service Plan Name"
  
}

variable "kind" {
    type = string
    description = "Kind"
  
}

variable "reserved" {
  type = bool
  description = "Reserved"
}

variable "sku_tier" {
  type = string
  description = "Sku Tier"
}

variable "sku_size" {
  type = string
  description = "Sku Size"
}
variable "app_service_name" {
    type = string
    description = "App Service Name"
  
}

variable "resource_group_name" {
    type = string
    description = "Resource Group Name"
}

variable "location" {
    type = string
    description = "Location"
}

variable "linux_fx_version" {
    type = string
    description = "value of site_config"
}

variable "app_settings" {
  description = "Container Environment Variables"
  type = map(string)
  default = {}
}


variable "container_registry_url" {
    description = "Azure contaier registry url"
}

variable "identity" {
  type = string
  description = "value of identity"
}

variable "private_registry_id" {
  type = string
  description = "value of private_registry_id"
}

variable "role_definition_name" {
  type = string
  description = "value of role_definition_name"
}

variable "principal_id" {
  description = "value of principal_id"
}

variable "private_registry_admin_username" {
  description = "value of private_registry_admin_username"
}

variable "private_registry_admin_password" {
  description = "value of private_registry_admin_password"
}