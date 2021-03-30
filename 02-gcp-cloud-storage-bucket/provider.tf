
terraform {
  required_providers {
     google = {
      source = "hashicorp/google"
      version = "3.61.0"
    }
  }
}


provider "google" {
  credentials = file(var.GCP_CRED_FILE_NAME)
  project     = var.GCP_PROJECT_ID
  region      = var.GCP_REGION
  zone        = var.GCP_ZONE
}

