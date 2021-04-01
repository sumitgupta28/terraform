
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.61.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>2.0" # Any version of 2.x range 
    }
  }
}


provider "google" {
  credentials = file(var.GCP_CRED_FILE_NAME)
  project     = var.GCP_PROJECT_ID
  region      = var.GCP_REGION
  zone        = var.GCP_ZONE
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}

