# variables.tf

variable "location" {
  description = "The Azure location where resources will be created."
  type        = string
  default     = "East US"
}

variable "allowed_ip" {
  description = "The IP address allowed to access the VM via RDP."
  type        = string
}

variable "admin_username" {
  description = "Admin username for the Windows VM."
  type        = string
  default     = "adminuser"
}
