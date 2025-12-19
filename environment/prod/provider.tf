terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }
    backend "azurerm" {
    resource_group_name  = "backend_rg"
    storage_account_name = "backend22"
    container_name       = "todoappinfra"
    key                  = "prod.todoapp.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "088412f5-0303-4050-9e53-2b794c57b126"
}









