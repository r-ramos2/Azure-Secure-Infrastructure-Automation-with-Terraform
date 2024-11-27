# main.tf

# Resource Group
resource "azurerm_resource_group" "tf-rg" {
  name     = "tf-rg"
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "tf-vnet" {
  name                = "tf-vnet"
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = azurerm_resource_group.tf-rg.location
  address_space       = ["10.0.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "tf-snet" {
  name                 = "tf-snet"
  resource_group_name  = azurerm_resource_group.tf-rg.name
  virtual_network_name = azurerm_virtual_network.tf-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP Address
resource "azurerm_public_ip" "tf-pip" {
  name                = "tf-pip"
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = azurerm_resource_group.tf-rg.location
  allocation_method   = "Static"
}

# Network Security Group
resource "azurerm_network_security_group" "tf-nsg" {
  name                = "tf-vm-nsg"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name
}

# NSG Rule: Allow RDP only from a specific IP
resource "azurerm_network_security_rule" "tf-nsg-rule" {
  name                        = "vm-rdp"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = var.allowed_ip
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.tf-rg.name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}

# Key Vault for storing sensitive information
resource "azurerm_key_vault" "tf-vault" {
  name                = "tf-vault"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name
}

# Secret for Admin Password
resource "azurerm_key_vault_secret" "admin_password" {
  name         = "admin-password"
  value        = "P@$$w0rd1234!"  # This should be securely managed
  key_vault_id = azurerm_key_vault.tf-vault.id
}

# Network Interface for VM
resource "azurerm_network_interface" "tf-vm-nic" {
  name                = "tf-vm-nic"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tf-snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id         = azurerm_public_ip.tf-pip.id
  }
}

# Windows Virtual Machine (VM)
resource "azurerm_windows_virtual_machine" "tf-vm" {
  name                = "tf-vm"
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = azurerm_resource_group.tf-rg.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = azurerm_key_vault_secret.admin_password.value
  network_interface_ids = [azurerm_network_interface.tf-vm-nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

# Output: Public IP address
output "public_ip_address" {
  value = azurerm_public_ip.tf-pip.ip_address
}
