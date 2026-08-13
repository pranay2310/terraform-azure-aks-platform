data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.acr_resource_group_name
}

resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "dev"
    Project     = "fastapi-gitops"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.dns_prefix

  sku_tier = "Free"

  default_node_pool {
    name    = "agentpool"
    vm_size = var.node_vm_size

    auto_scaling_enabled = true
    min_count            = var.min_nodes
    max_count            = var.max_nodes

    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  role_based_access_control_enabled = true

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    load_balancer_sku   = "standard"
  }

  tags = {
    Environment = "dev"
    Project     = "fastapi-gitops"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_role_assignment" "aks_acr_reader" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "Container Registry Repository Reader"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id

  condition_version = "2.0"

  condition = <<-EOT
    (
      (
        !(ActionMatches{'Microsoft.ContainerRegistry/registries/repositories/content/read'})
        AND
        !(ActionMatches{'Microsoft.ContainerRegistry/registries/repositories/metadata/read'})
      )
      OR
      (
        @Request[Microsoft.ContainerRegistry/registries/repositories:name] StringEqualsIgnoreCase '${var.acr_repository}'
      )
    )
  EOT

  description = "AKS pull access to FastAPI repository"
}