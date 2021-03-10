terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.40"
    }

    google = {
      source  = "hashicorp/google"
      version = "<=3.50"
    }

    //kubernetes = {
    //  source = "hashicorp/kubernetes"
    //  version = ">=2.0,<=3.0"
    //}
  }

  provider "kubernetes" {
    version = ">=2.0,<=3.0"
  }
}