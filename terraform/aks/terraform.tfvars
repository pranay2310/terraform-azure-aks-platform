location            = "East US"
resource_group_name = "rg-terraform-aks"
aks_name            = "aks-fastapi-terraform"
dns_prefix          = "aks-fastapi-terraform"

acr_name                = "pranayacr12345"
acr_resource_group_name = "rg-eastus"

node_vm_size = "Standard_D2alds_v6"

min_nodes = 2
max_nodes = 5

acr_repository = "fastapi-gitops-demo"