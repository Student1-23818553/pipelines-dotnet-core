terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.8.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "myrg"
    storage_account_name = "tfstatelock"
    container_name       = "tfstatelock"
    key                  = "training1.tfstate"
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}
