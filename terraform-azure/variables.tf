variable "resource_group_location" {
  type = string
  description = "Location of the resource group."
}

variable "agent_count" {
  default = 1
}

variable "cluster_name" {
  type = string
  description = "AKS name in Azure"
}

variable "kubernetes_version" {
type = string
description = "Kubernetes version"
}

variable "system_node_count" {
type = number
description = "Number of AKS worker nodes"
}