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

## Create a VPC network
resource "google_compute_network" "terraform-network-vpc" {
  name = "terraform-network"
  description = "a Test vpc Network"
  auto_create_subnetworks = false
  routing_mode= "REGIONAL"
  
}

## Create a Subnet
resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "us-central1-subnetwork"
  description = "us-central1-subnetwork"
  ip_cidr_range = "10.0.0.0/12"
  region        = "us-central1"
  network       = google_compute_network.terraform-network-vpc.id
}

## Create a firewall rule
resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.terraform-network-vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_tags = ["web"]
}
