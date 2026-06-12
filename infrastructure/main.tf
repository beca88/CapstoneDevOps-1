# -----------------------------
# 1. Terraform & Providers
# -----------------------------
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -----------------------------
# 2. Resource Group
# -----------------------------
resource "azurerm_resource_group" "capstone_rg" {
  name     = "rg-capstone-project"
  location = "eastus"

  tags = {
    project = "capstone"
  }
}

# -----------------------------
# 3. Random suffix for ACR name
# -----------------------------
resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

# -----------------------------
# 4. Azure Container Registry
# -----------------------------
resource "azurerm_container_registry" "capstone_acr" {
  name                = "acrcapstone${random_integer.suffix.result}"
  resource_group_name = azurerm_resource_group.capstone_rg.name
  location            = azurerm_resource_group.capstone_rg.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    project = "capstone"
  }
}

# -----------------------------
# 5. Outputs (IMPORTANT)
# -----------------------------
output "resource_group_name" {
  value = azurerm_resource_group.capstone_rg.name
}

output "acr_name" {
  value = azurerm_container_registry.capstone_acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.capstone_acr.login_server
}
`