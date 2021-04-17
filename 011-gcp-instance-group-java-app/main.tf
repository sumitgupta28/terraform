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

variable "GCP_BUCKET_NAME" {
  default = "sumitgupta28-code-bucket"
}

resource "google_storage_bucket" "code-bucket" {
  name                        = var.GCP_BUCKET_NAME
  storage_class               = "NEARLINE"
  location                    = "US" ## multi Region
  force_destroy               = true
  project                     = var.GCP_PROJECT_ID
  uniform_bucket_level_access = true



}
resource "google_storage_bucket_object" "application-jar-copy" {
  name   = "ocp-demo-app.jar"
  source = "jar/ocp-demo-app.jar"
  bucket = var.GCP_BUCKET_NAME
  depends_on = [
    google_storage_bucket.code-bucket
  ]
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
  name    = "allow-icmp-terraform-network"
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
  name    = "allow-ssh-terraform-network"
  network = google_compute_network.terraform-network-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]

  priority    = 65534
  source_tags = ["web"]
}

## Create a firewall rule - allow-http
resource "google_compute_firewall" "allow-http" {
  name    = "allow-http-terraform-network"
  network = google_compute_network.terraform-network-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  source_ranges = ["0.0.0.0/0"]

  priority    = 65534
  source_tags = ["web"]
}

## Create Router 
resource "google_compute_router" "my-router" {
  name        = "my-router"
  description = "my-router"
  network     = google_compute_network.terraform-network-vpc.name
  region      = var.GCP_REGION
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
  template = file("${path.module}/script/install_java_start_app.sh")
}



resource "google_service_account" "bucket-access-sa" {
  account_id   = "bucket-access-sa"
  display_name = "Bucket Access SA"
  project      = var.GCP_PROJECT_ID
}

resource "google_project_iam_member" "storage_owner_binding" {
  project = var.GCP_PROJECT_ID
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.bucket-access-sa.email}"
  /*- https://www.googleapis.com/auth/devstorage.read_only
    - https://www.googleapis.com/auth/logging.write
    - https://www.googleapis.com/auth/monitoring.write
    - https://www.googleapis.com/auth/servicecontrol
    - https://www.googleapis.com/auth/service.management.readonly
    - https://www.googleapis.com/auth/trace.append*/
}
## Instance Template 
resource "google_compute_instance_template" "terraform-maintained-it" {
  name        = "terraform-maintained-instance-template"
  description = "instance Template maintained by Terraform"

  network_interface {
    access_config {} ## this will generate dynamic public ip address.
    network    = google_compute_network.terraform-network-vpc.id
    subnetwork = google_compute_subnetwork.us-central1-private-subnet.name
  }
  machine_type = "f1-micro"
  disk {
    source_image = "debian-10"
    auto_delete  = true
    disk_size_gb = 10
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  metadata_startup_script = data.template_file.nginx.rendered
  instance_description    = "instance maintained by Terraform"
  can_ip_forward          = false


  labels = {
    environment = "dev"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.bucket-access-sa.email
    scopes = ["cloud-platform"]
  }

}

### create an instance group manager with Instance Template 
resource "google_compute_instance_group_manager" "java-applicaation-instance-group" {
  name               = "java-applicaation-instance-group"
  description        = "terraform Maintained Instance Group"
  zone               = var.GCP_ZONE
  project            = var.GCP_PROJECT_ID
  base_instance_name = "terraform-maintained"

  version {
    instance_template = google_compute_instance_template.terraform-maintained-it.id
  }
  target_size = 1

  depends_on = [
    google_storage_bucket_object.application-jar-copy
  ]

  auto_healing_policies {
    health_check      = google_compute_http_health_check.java-service-health-check.id
    initial_delay_sec = 300
  }
}


// Forwarding rule for External Network Load Balancing using Backend Services
resource "google_compute_global_forwarding_rule" "java-app-http-loadbalancer-fwd-rule" {
  name       = "http-loadbalancer-fwd-rule"
  target     = google_compute_target_http_proxy.java-app-target-http-proxy.id
  port_range = "8080"
}

resource "google_compute_target_http_proxy" "java-app-target-http-proxy" {
  name        = "java-app-target-http-proxy"
  description = "a description"
  url_map     = google_compute_url_map.java-app-loadbalancer.id
}

resource "google_compute_url_map" "java-app-loadbalancer" {
  name            = "java-app-loadbalancer"
  description     = "java App Loadbalancer"
  default_service = google_compute_backend_service.java-app-backend-service.id
  project            = var.GCP_PROJECT_ID
}

resource "google_compute_backend_service" "java-app-backend-service" {
  name = "website-backend"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_http_health_check.java-service-health-check.id]
  
  backend {
    group           = google_compute_instance_group_manager.java-applicaation-instance-group.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
    max_utilization = 0.8
  }
}

resource "google_compute_http_health_check" "java-service-health-check" {
  name                = "java-service-health-check"
  description         = "java-service-health-check"
  request_path        = "/api/health"
  healthy_threshold   = 2
  unhealthy_threshold = 3
  check_interval_sec  = 10
  timeout_sec         = 5

  port = 8080

  # response = "App is Healthy"
}

