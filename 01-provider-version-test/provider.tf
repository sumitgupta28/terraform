terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>2.0" # Any version of 2.x range 
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.40" # Greater then or eq to 2.40
    }

    google = {
      source  = "hashicorp/google"
      version = "<=3.50" # less then or eq to 2.40
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=2.0,<=3.0" # Any version between 2.0 and 3.0
    }
  }
}