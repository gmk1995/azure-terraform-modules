variable "dockerfile_path" {
  type        = string
  description = "Path to the Dockerfile"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "Tag to apply to the built image"
}
variable "image_name" {
  type        = string
  description = "Name of the built image"
}


variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

variable "login_server" {
    description = "Login server of the Azure Container Registry"
}

variable "admin_username" {
    description = "Username for the Azure Container Registry"
}

variable "admin_password" {
    description = "Password for the Azure Container Registry"
}
