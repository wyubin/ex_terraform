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
    storage_account_name = "tfstate2a6e9e4a6b0a537b"
    container_name       = "tfstate"
    key                  = "_poc/container_registry/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
