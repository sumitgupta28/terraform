
terraform {
  required_version = ">= 0.13"

  backend "gcs" {
    bucket = "sumitgupta28-terraform-state-bucket"
    prefix = "terraform.tfstate"
  }
}
