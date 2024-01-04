variable "resource_group_name" {
    type = string
    description = "Resource Group Name"
  
}

variable "location" {
    type = string
    description = "Resource Group Location"
  
}

variable "log_analytics_workspace_name" {
    type = string
    description = "Log Analytics Workspace Name"
  
}

variable "sku" {
    type = string
    description = "Log Analytics Workspace SKU"
  
}

variable "retention_in_days" {
  type = number
  description = "value for retention_in_days"
}

variable "azurerm_container_app_environment_name" {
  type = string
  description = "Name of the container app environment"
}

variable "azurerm_container_app_name" {
    type = string
    description = "value for azurerm_container_app_name" 
}

variable "revision_mode" {
  type = string
  description = "value for revision_mode"
}

variable "server" {
  type = string
  description = "value for registry_url"
}

variable "username" {
    sensitive = true
    type = string
    description = "value for username"
  
}

variable "password" {
    sensitive = true
    type = string
    description = "value for password"
  
}

variable "container_name" {
  type = string
  description = "container name"
}

variable "container_image" {
  type = string
  description = "container image"
}

variable "cpu" {
  type = number
  description = "cpu"
}

variable "memory" {
  description = "memory"
}

variable "environment_variables_name" {
  type = string
  description = "environment variables name"
}

variable "environment_variables_value" {
  type = string
  description = "environment variables value"
}

variable "ingress_enabled" {
  type = bool
  description = "value for ingress_enabled"
}

variable "target_port" {
  type = number
  description = "value"
}

variable "percentage" {
  type = number
  description = "value for percentage"
}

variable "latest_revision" {
  type = bool
  description = "value for latest_revision"
}

variable "identity" {
  type = string
  description = "value for identity"
}

variable "secret_name" {
  type = string
  description = "value for secret_name"
}
