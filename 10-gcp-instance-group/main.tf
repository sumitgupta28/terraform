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
  source_ranges = ["0.0.0.0/0"]

  priority    = 65534
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
  source_ranges = ["0.0.0.0/0"]

  priority    = 65534
  source_tags = ["web"]
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

## Refrence to Template file to be executed on instance startup
data "template_file" "nginx" {
  template = file("${path.module}/script/install_nginx.sh")
}


## Instance Template 
resource "google_compute_instance_template" "terraform-maintained-it" {
  name        = "terraform-maintained-instance-template"
  description = "instance Template maintained by Terraform"

  network_interface {
    network    = google_compute_network.terraform-network-vpc.id
    subnetwork = google_compute_subnetwork.us-central1-private-subnet.name
  }
  machine_type = "f1-micro"
  disk {
    source_image = "debian-10"
    auto_delete  = true
    disk_size_gb = 10
  }

  metadata_startup_script = data.template_file.nginx.rendered
  instance_description    = "instance maintained by Terraform"
  can_ip_forward          = false

  labels = {
    environment = "dev"
  }

  scheduling {
    automatic_restart = false
  }
}

### create an instance group manager with Instance Template 
resource "google_compute_instance_group_manager" "terraform-maintained-ig" {
  name               = "terraform-maintained-ig"
  description        = "terraform Maintained Instance Group"
  zone               = var.GCP_ZONE
  project            = var.GCP_PROJECT_ID
  base_instance_name = "terraform-maintained"

  version {
    instance_template = google_compute_instance_template.terraform-maintained-it.id
  }
  target_size = 1
}
