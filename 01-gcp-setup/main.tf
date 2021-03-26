## Define variables for Google Provider
variable "GCP_PROJECT_ID" {
}
variable "GCP_REGION" {
}
variable "GCP_ZONE" {
}
variable "GCP_CRED_FILE_NAME" {
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file(var.GCP_CRED_FILE_NAME)
  project     = var.GCP_PROJECT_ID
  region      = var.GCP_REGION
  zone        = var.GCP_ZONE
}

## Create a VPC network
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

## Create a VM instance
resource "google_compute_instance" "app-instance" {
  name         = "test-app-server"
  machine_type = "f1-micro"
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id

  }
}

## Create a storage bucket
resource "google_storage_bucket" "test-bucket" {
  name = "sumitgupta28-testbucket-xxx"
}