## Define variables for Google Provider
variable "GCP_PROJECT_ID" {
}
variable "GCP_REGION" {
}
variable "GCP_ZONE" {
}
variable "GCP_CRED_FILE_NAME" {
}


variable "GKE-CLUSTER-NAME" {
  default = "demo-cluster"
}

variable "INIT_NODE_COUNT" {
  default = 1
}

variable "MACHINE_TYPE" {
  default = "n1-standard-1"
}

## Provider Details.

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


## google_container_cluster.

resource "google_container_cluster" "gke-cluster" {
  name        = var.GKE-CLUSTER-NAME
  project     = var.GCP_PROJECT_ID
  description = "Demo GKE Cluster"
  location    = var.GCP_ZONE

  remove_default_node_pool = true
  initial_node_count       = var.INIT_NODE_COUNT

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "default" {
  name       = "${var.GKE-CLUSTER-NAME}-node-pool"
  project    = var.GCP_PROJECT_ID
  location   = var.GCP_ZONE
  cluster    = google_container_cluster.gke-cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.MACHINE_TYPE

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}