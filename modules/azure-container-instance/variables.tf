variable "acg_name" {
    type = string
    description = "Azure Container Group Name"
  
}
variable "acg_ip_address_type" {
    type = string
    description = "Azure Container Group IP Address Type"
  
}
variable "acg_dns_name_label" {
    type = string
    description = "Azure Container Group DNS Name Label"
  
}
variable "acg_os_type" {
    type = string
    description = "Azure Container Group OS Type"
  
}

variable "location" {
    type = string
    description = "Azure Container Group Location"
  
}
variable "resource_group_name" {
    type = string
    description = "Azure Container Group Resource Group Name"
}

variable "container_name" {
  type = string
  description = "Container Name"
}

variable "container_image" {
  description = "Container Image"
}

variable "container_cpu" {
  description = "Container CPU"
}

variable "container_memory" {
  description = "Container Memory"
}

variable "container_environment_variables" {
  description = "Container Environment Variables"
  type = list(object({
    name = string
    value = string
  }))
}

variable "container_ports" {
  description = "Container Ports"
  type = list(object({
    port = number
    protocol = string
  }))
}

variable "registry_login_server" {
  description = "Azure container registry login server"
}

variable "admin_username" {
    description = "Username for the Azure Container Registry"
}

variable "admin_password" {
    description = "Password for the Azure Container Registry"
}


variable "image_tag" {
  type        = string
  default     = "latest"
  description = "Tag to apply to the built image"
}