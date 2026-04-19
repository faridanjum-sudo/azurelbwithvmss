terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.66.0"
    }

 azuread = {
      source  = "hashicorp/azuread"
      version = "3.8.0"
    }
    
  }
}

provider "azurerm" {
subscription_id = "<enter your subs id>"
client_id = "<enter your client id>"
client_secret = "<enter your secret value id>"
tenant_id = "<enter your tenant id>"
features {
  
}
}



