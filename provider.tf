terraform {
  required_providers {
    azurerm = {

      source = "hashicorp/azurerm"

      version = "~> 3.0"

    }

    azuread = {

      source = "hashicorp/azuread"

      version = "~> 2.0"

    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }


  }

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # Configuration options

  subscription_id = "subscription_id"

  tenant_id = "tenant_id"

  client_id = "client_id"

  client_secret = "client_secret"


  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }

  }

}

provider "azuread" {
  # Configuration options
  tenant_id = "tenant_id"

  client_id = "client_id"

  client_secret = "client_secret"


}
