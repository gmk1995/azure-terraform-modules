
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
      host = "npipe:////./pipe/docker_engine"
      registry_auth {
              address  = "${var.acr_name}.azurecr.io"
              username = var.admin_username
              password = var.admin_password
     }
    }

resource "docker_registry_image" "acr_image" {
  name          = "${var.acr_name}.azurecr.io/${var.image_name}:${var.image_tag}"
  keep_remotely = true
}

resource "docker_image" "acr_image" {
  name = "${var.acr_name}.azurecr.io/${var.image_name}:${var.image_tag}"
  build {
    context = path.module
    dockerfile = var.dockerfile_path
  }
}

# Ensure that the ACR image is pushed before continuing with other resources
resource "null_resource" "acr_image_dependency" {
  depends_on = [docker_image.acr_image]
}