variable "location" {
  description = "Azure region for AKS"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for AKS"
  type        = string
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "dns_prefix" {
  description = "AKS DNS prefix"
  type        = string
}

variable "acr_name" {
  description = "Existing Azure Container Registry name"
  type        = string
}

variable "acr_resource_group_name" {
  description = "Resource group containing ACR"
  type        = string
}

variable "node_vm_size" {
  description = "AKS node VM size"
  type        = string
}

variable "min_nodes" {
  description = "Minimum AKS nodes"
  type        = number
}

variable "max_nodes" {
  description = "Maximum AKS nodes"
  type        = number
}