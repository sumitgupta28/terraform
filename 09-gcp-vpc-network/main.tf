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
  name                    = "terraform-network"
  description             = "a Test vpc Network"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

## Create a Public Subnet
resource "google_compute_subnetwork" "us-central1-public-subnet" {
  name          = "us-central1-public-subnet"
  description   = "us-central1-public-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.GCP_REGION
  network       = google_compute_network.terraform-network-vpc.id
}

## Create a private Subnet
resource "google_compute_subnetwork" "us-central1-private-subnet" {
  name          = "us-central1-private-subnet"
  description   = "us-central1-private-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.GCP_REGION
  network       = google_compute_network.terraform-network-vpc.id
}


## Create a firewall rule - allow-icmp
resource "google_compute_firewall" "allow-icmp-custom" {
  name    = "allow-icmp-custom"
  network = google_compute_network.terraform-network-vpc.name
  allow {
    protocol = "icmp"
    
  }
  source_ranges = [ "0.0.0.0/0" ]

  priority = 65534
  source_tags = ["web"]
}


## Create a firewall rule - allow-ssh
resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-icmp"
  network = google_compute_network.terraform-network-vpc.name
  
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [ "0.0.0.0/0" ]

  priority = 65534
  source_tags = ["web"]
}

## Create a VM instance in public subnet
resource "google_compute_instance" "app-instance-public" {
  name         = "test-app-server"
  machine_type = "f1-micro"
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    access_config {
    }
    network    = google_compute_network.terraform-network-vpc.id
    subnetwork = google_compute_subnetwork.us-central1-public-subnet.name
  }
}

output "test-app-server-public-nat_ip" {
  value = google_compute_instance.app-instance-public.network_interface[0].access_config[0].nat_ip
}
output "test-app-server-private-ip" {
  value = google_compute_instance.app-instance-public.network_interface[0].network_ip
}




## Create a VM instance in private subnet
resource "google_compute_instance" "app-instance-private" {
  name         = "test-backend-server"
  machine_type = "f1-micro"
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network    = google_compute_network.terraform-network-vpc.id
    subnetwork = google_compute_subnetwork.us-central1-private-subnet.name
  }
}

output "test-backend-app-instance-private-ip" {
  value = google_compute_instance.app-instance-private.network_interface[0].network_ip
}



## Create Router 
resource "google_compute_router" "my-router" {
  name    = "my-router"
  description = "my-router"
  network = google_compute_network.terraform-network-vpc.name
  region                             = var.GCP_REGION
}

## Create NAT Gateway
resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.my-router.name
  region                             = var.GCP_REGION
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}