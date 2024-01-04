variable "resource_group_name" {
  type = string
  description = "Azure resource group name"
}

variable "location" {
  type = string
  description = "Azure location"
}

variable "aks_cluster_name" {
  type = string
  description = "value of aks cluster name"
}

variable "dns_prefix" {
  type = string
  description = "value of dns prefix"
}

variable "default_node_pool_name" {
  type = string
  description = "value of default node pool name"
}

variable "default_node_pool_node_count" {
  type = number
  description = "value of default node pool node count"
}

variable "default_node_pool_vm_size" {
  type = string
  description = "value of default node pool vm size"
}

variable "identity_type" {
  type = string
  description = "value of identity type"
}

variable "acrpullrole" {
  type = string
  description = "value of acr pull role"
}

variable "acr_name" {
  type = string
  description = "value of acr name"
}

variable "azurerm_user_assigned_identity_name" {
  type = string
  description = "value of azurerm user assigned identity name"
}

variable "keyvault_id" {
  type = string
  description = "Key Vault ID"
  
}

variable "aks_secret_permissions" {
  type        = list(string)
  description = "List of permissions to assign to the Assigned Identity"
  default = [  ]
}

variable "k8s_secret_name" {
  type = string
  description = "value of k8s secret name"
}

variable "k8s_secret_value" {
  type = string
  description = "value of k8s secret value"
}

variable "key_vault_admin_role_assignment" {
  type = string
  description = "value of key vault admin role assignment"
}

variable "key_vault_admin_role_assignment_scope" {
  type = string
  description = "value of key vault admin role assignment scope"
}