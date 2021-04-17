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
        kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "google" {
  credentials = file(var.GCP_CRED_FILE_NAME)
  project     = var.GCP_PROJECT_ID
  region      = var.GCP_REGION
  zone        = var.GCP_ZONE
}


resource "google_service_account" "gke-service-account" {
  account_id   = "gke-service-account"
  display_name = "GKE Service Account"
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = var.GCP_REGION

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  # remove_default_node_pool = true



  initial_node_count       = 3
  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }

}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.GCP_REGION
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke-service-account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]
  }
}

output "cluster_ca_certificate" {
  value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}

output "endpoint" {
  value = google_container_cluster.primary.endpoint
}


output "client_certificate" {
  value = google_container_cluster.primary.master_auth.0.client_certificate
}

output "client_key" {
  value = google_container_cluster.primary.master_auth.0.client_key
}


/*
provider "kubernetes" {
  host = google_container_cluster.primary.endpoint
  client_certificate     = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.primary.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}


resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "scalable-nginx-example"
    labels = {
      App = "ScalableNginxExample"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableNginxExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginxExample"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "example"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}*/