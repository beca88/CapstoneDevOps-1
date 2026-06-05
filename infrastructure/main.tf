# 1. Configuration of the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 2. Creation of the Resource Group for the Capstone Project
resource "azurerm_resource_group" "capstone_rg" {
  name     = "rg-capstone-project"
  location = "australiaeast"
}

# 3. Creation of the Azure Container Registry (ACR)
# Note: ACR names must be globally unique and contain only lowercase letters/numbers
resource "azurerm_container_registry" "capstone_acr" {
  name                = "acrcapstone${random_integer.suffix.result}"
  resource_group_name = azurerm_resource_group.capstone_rg.name
  location            = azurerm_resource_group.capstone_rg.location
  sku                 = "Basic" # Basic is the cheapest for student accounts
  admin_enabled       = true
}

# Generate a random number to ensure the ACR name is unique
resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

# 4. Creation of the Azure Kubernetes Service (AKS) Cluster
resource "azurerm_kubernetes_cluster" "capstone_aks" {
  name                = "aks-capstone-cluster"
  location            = azurerm_resource_group.capstone_rg.location
  resource_group_name = azurerm_resource_group.capstone_rg.name
  dns_prefix          = "akscapstone"

  # Student Subscription Workaround: Use Standard_B2s and limit to 1 node to stay under 4 vCPU quota
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s" 
  }

  identity {
    type = "SystemAssigned"
  }
}

# 5. Grant AKS permission to pull images from ACR
resource "azurerm_role_assignment" "aks_to_acr" {
  principal_id                     = azurerm_kubernetes_cluster.capstone_aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.capstone_acr.id
  skip_service_principal_aad_check = true
}
