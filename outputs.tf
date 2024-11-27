# outputs.tf

output "public_ip_address" {
  value = azurerm_public_ip.tf-pip.ip_address
}

