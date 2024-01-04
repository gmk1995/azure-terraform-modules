#Azure Resource Group Module
module "rg" {
  source = "./modules/azure-resource-group"

  azurerm_resource_group = "task8-rg"
  location               = "centralindia"
}

#Azure key vault and access policy Module
module "key_vault" {
  source = "./modules/azure-keyvault"

  key_vault_name                                           = "task8-kv"
  location                                                 = module.rg.location
  resource_group_name                                      = module.rg.resource_group_name
  key_vault_sku                                            = "premium"
  key_permissions_aduser                                   = ["Get", "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
  secret_permissions_aduser                                = ["Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set"]
  certificate_permissions_aduser                           = ["Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "SetIssuers", "Update", "Backup", "Restore"]
  azuread_service_principal_az-tf-automation-app_object_id = "b38116b2-ce68-4bcc-af77-394761e851b5"
  key_permissions_az-tf-automation-app                     = ["Get", "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
  secret_permissions_az-tf-automation-app                  = ["Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set"]
  certificate_permissions_az-tf-automation-app             = ["Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "SetIssuers", "Update", "Backup", "Restore"]
  depends_on                                               = [module.rg]
}

#Azure Redis Cache Module

module "azure-redis-cache" {
  source = "./modules/azure-redis-cache"

  azurerm_redis_cache_name  = "task8-myrediscache"
  location                  = module.rg.location
  azurerm_resource_group    = module.rg.resource_group_name
  sku                       = "Premium"
  redis_capacity            = 1
  redis_family              = "P"
  redis_enable_non_ssl_port = true
  redis_minimum_tls_version = "1.2"
  depends_on                = [module.key_vault]
}

#Azure Key Vault Secret Module
module "azure-keyvault-secret" {
  source                                 = "D:\\DevOps_Practices\\azure-terraform-modules\\modules\\azure-keyvault-secrets"
  key_vault_id                           = module.key_vault.key_vault_id
  redis-cache-password-name              = "redis-cache-password-name"
  azurerm_redis_cache_primary_access_key = module.azure-redis-cache.azurerm_redis_cache_primary_access_key
  redis-cache-hostname-name              = "redis-cache-hostname-name"
  azurerm_redis_cache_hostname           = module.azure-redis-cache.azurerm_redis_cache_hostname
  depends_on                             = [module.azure-redis-cache]
}

#Azure Container Registry Module
module "azure-container-registry" {
  source = "./modules/azure-container-registry"

  acr_name            = "task8acr"
  location            = module.rg.location
  resource_group_name = module.rg.resource_group_name
  sku                 = "Premium"
  admin_enabled       = true
  login_server        = module.azure-container-registry.login_server
  admin_username      = module.azure-container-registry.admin_username
  admin_password      = module.azure-container-registry.admin_password
  dockerfile_path     = "D:\\DevOps_Practices\\azure-terraform-modules\\modules\\azure-container-registry\\Dockerfile"
  image_tag           = "python-flask-webapp:v1"
}

#Docker Build Module
module "docker-build" {
  source          = "./modules/docker-build"
  acr_name        = "task8acr"
  login_server    = module.azure-container-registry.login_server
  admin_username  = module.azure-container-registry.admin_username
  admin_password  = module.azure-container-registry.admin_password
  dockerfile_path = ".\\Dockerfile"
  image_name      = "python-flask-webapp"
  image_tag       = "v1"
}

#Azure Container Instance Module


module "azure-container-instance" {
  source = "./modules/azure-container-instance"

  acg_name            = "task8-aci"
  location            = module.rg.location
  resource_group_name = module.rg.resource_group_name
  container_image = join("/", [
    module.azure-container-registry.login_server,
    "python-flask-webapp:v1",
  ])
  registry_login_server = module.azure-container-registry.login_server
  admin_username        = module.azure-container-registry.admin_username
  admin_password        = module.azure-container-registry.admin_password
  acg_ip_address_type   = "Public"
  acg_dns_name_label    = "task8-aci"
  acg_os_type           = "Linux"
  container_name        = "task8-aci"
  container_cpu         = "1"
  container_memory      = "1.5"
  container_environment_variables = [
    {
      name  = "CREATOR"
      value = "Azure_Container_Instance"
    }
  ]
  container_ports = [
    {
      port     = 8080
      protocol = "TCP"
    }
  ]
}

#Azure App Service

module "azure-webapps" {
  source = "./modules/azure-webapps"

  app_service_name                = "task8-webapp"
  location                        = "eastus"
  resource_group_name             = module.rg.resource_group_name
  service_plan_name               = "task8-webapp-plan"
  sku_tier                        = "Basic"
  sku_size                        = "B2"
  kind                            = "Linux"
  reserved                        = true
  container_registry_url          = module.azure-container-registry.login_server
  linux_fx_version                = "DOCKER|${module.azure-container-registry.login_server}/python-flask-webapp:v1"
  private_registry_admin_username = module.azure-container-registry.admin_username
  private_registry_admin_password = module.azure-container-registry.admin_password
  app_settings = {
    CREATOR                             = "Azure_Web_APP"
    DOCKER_REGISTRY_SERVER_URL          = module.azure-container-registry.login_server
    DOCKER_REGISTRY_SERVER_USERNAME     = module.azure-container-registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD     = module.azure-container-registry.admin_password
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
  identity             = "SystemAssigned"
  private_registry_id  = module.azure-container-registry.id
  role_definition_name = "AcrPull"
  principal_id         = module.azure-webapps.principal_id
  depends_on           = [module.azure-container-registry]

}

#Azure Container App

module "azure-container-apps" {
  source                                 = "./modules/azure-container-apps"
  log_analytics_workspace_name           = "task8-log-analytics-workspace"
  location                               = module.rg.location
  resource_group_name                    = module.rg.resource_group_name
  sku                                    = "PerGB2018"
  retention_in_days                      = 30
  azurerm_container_app_environment_name = "task8-container-app-environment"
  revision_mode                          = "Single"
  azurerm_container_app_name             = "task8-container-app"
  secret_name                            = "password"
  server                                 = module.azure-container-registry.login_server
  username                               = module.azure-container-registry.admin_username
  password                               = module.azure-container-registry.admin_password
  ingress_enabled                        = true
  target_port                            = 8080
  percentage                             = 100
  latest_revision                        = true
  container_name                         = "task8-container"
  container_image                        = "${module.azure-container-registry.login_server}/python-flask-webapp:v1"
  cpu                                    = "0.75"
  memory                                 = "1.5Gi"
  environment_variables_name             = "CREATOR"
  environment_variables_value            = "Azure_Container_App"
  identity                               = "SystemAssigned"
  depends_on                             = [module.azure-container-registry]

}

#Azure Kubernetes Service

module "azure-kubernetes-cluster" {
  source                                = "./modules/azure-kubernetes-cluster"
  aks_cluster_name                      = "task8-aks-cluster"
  location                              = module.rg.location
  resource_group_name                   = module.rg.resource_group_name
  dns_prefix                            = "task8-aks-cluster"
  default_node_pool_name                = "task8np"
  default_node_pool_node_count          = 1
  default_node_pool_vm_size             = "Standard_D2_v2"
  identity_type                         = "UserAssigned"
  acrpullrole                           = "AcrPull"
  acr_name                              = module.azure-container-registry.id
  azurerm_user_assigned_identity_name   = "task8-aks-secret-assigned-identity"
  keyvault_id                           = module.key_vault.key_vault_id
  aks_secret_permissions                = ["Get", "List"]
  k8s_secret_name                       = "creator"
  k8s_secret_value                      = "K8S"
  key_vault_admin_role_assignment       = "Key Vault Administrator"
  key_vault_admin_role_assignment_scope = module.key_vault.key_vault_id
  depends_on                            = [module.azure-container-registry]
}