
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

  ## Just for demo using tje default network
  network_interface {
    network = "default"
  }

}

## Create a storage bucket
resource "google_storage_bucket" "test-bucket" {
  name = "sumitgupta28-testbucket-xxx"
}