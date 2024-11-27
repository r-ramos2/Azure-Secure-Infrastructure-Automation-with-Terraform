# providers.tf

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.66.0"  # Explicit version pinning to ensure consistency
    }
  }
}

provider "azurerm" {
  features {}  # Enable all features by default
}
