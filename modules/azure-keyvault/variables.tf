variable "resource_group_name" {
  type = string
  description = "value of the resource group name"
}

variable "location" {
  type = string
  description = "value of the location"
}
variable "key_vault_name" {
    type        = string
    description = "Azure Key Vault Name"
  
}

variable "key_vault_sku" {
  type        = string
  description = "The SKU of the Key Vault to create"
}

variable "key_permissions_aduser" {
  type        = list(string)
  description = "List of permissions to assign to the key"
  default = [  ]
}

variable "secret_permissions_aduser" {
  type = list(string)
  description = "List of permissions to assign to the secret"
  default = [  ]
}

variable "certificate_permissions_aduser" {
  type = list(string)
  description = "List of permissions to assign to the certificate"
  default = [  ]
}

variable "key_permissions_az-tf-automation-app" {
  type = list(string)
  description = "List of permissions to assign to the key"
  default = [  ]
}

variable "secret_permissions_az-tf-automation-app" {
  type = list(string)
  description = "List of permissions to assign to the secret"
  default = [  ]
}

variable "certificate_permissions_az-tf-automation-app" {
  type = list(string)
  description = "List of permissions to assign to the certificate"
  default = [  ]
}

variable "azuread_service_principal_az-tf-automation-app_object_id" {
    type = string
    description = "value of object_id for the azuread_service_principal.az-tf-automation-app"
  
}