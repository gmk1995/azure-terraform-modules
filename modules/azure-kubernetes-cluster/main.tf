resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.default_node_pool_node_count
    vm_size    = var.default_node_pool_vm_size
    
  }

  identity {
    type = var.identity_type
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }
 azure_policy_enabled = true
 key_vault_secrets_provider {
     secret_rotation_enabled  = true
 }


}

resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = var.acrpullrole
  scope                            = var.acr_name
  skip_service_principal_aad_check = true
}

resource "azurerm_user_assigned_identity" "aks_identity" {
  name = var.azurerm_user_assigned_identity_name
  location = var.location
  resource_group_name = var.resource_group_name
}
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "aks_access_policy" {
  key_vault_id = var.keyvault_id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azurerm_user_assigned_identity.aks_identity.principal_id

  secret_permissions = var.aks_secret_permissions
}


resource "azurerm_key_vault_secret" "k8s_secret" {
  name         = var.k8s_secret_name
  value        = var.k8s_secret_value
  key_vault_id = var.keyvault_id
}

resource "azurerm_role_assignment" "key_vault_admin_role_assignment" {
  principal_id                     = azurerm_user_assigned_identity.aks_identity.principal_id
  role_definition_name             = var.key_vault_admin_role_assignment
  scope                            = var.key_vault_admin_role_assignment_scope
  #skip_service_principal_aad_check = true
}