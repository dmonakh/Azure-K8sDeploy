terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "storageMon"
    storage_account_name = "stForK8s"
    container_name       = "st"
    key                  = "terraform.st"
  }
}

provider "azurerm" {
  features {}
}