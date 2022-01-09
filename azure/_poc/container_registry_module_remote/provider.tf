terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65.0"
    }
  }
  # remote Backend
  backend "azurerm" {
    resource_group_name  = "ex-terraform-poc"
    storage_account_name = "tfstate5d3bb65ad3a99fab"
    container_name       = "tfstate"
    key                  = "_poc/container_registry/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
