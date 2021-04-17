## Define variables for Google Provider
variable "GCP_PROJECT_ID" {}
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
resource "google_storage_bucket_object" "application-zip-copy" {
  name   = "code-zip.zip"
  source = "code-zip/code-zip.zip"
  bucket = var.GCP_BUCKET_NAME
  depends_on = [
    google_storage_bucket.code-bucket
  ]
}

resource "google_app_engine_standard_app_version" "gcp-app-engine-sample-v1" {
  version_id = "v1"
  service    = "gcp-app-engine-sample"
  runtime    = "java11"
  project    = var.GCP_PROJECT_ID
  deployment {

    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.code-bucket.name}/${google_storage_bucket_object.application-zip-copy.name}"
    }
  }
  delete_service_on_destroy = true
}

resource "google_app_engine_standard_app_version" "gcp-app-engine-sample-v2" {
  version_id = "v2"
  service    = "gcp-app-engine-sample"
  runtime    = "java11"
  project    = var.GCP_PROJECT_ID
  deployment {

    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.code-bucket.name}/${google_storage_bucket_object.application-zip-copy.name}"
    }
  }
  delete_service_on_destroy = true
}


resource "google_app_engine_service_split_traffic" "liveapp" {
  service = google_app_engine_standard_app_version.gcp-app-engine-sample-v2.service

  migrate_traffic = false
  split {
    shard_by = "RANDOM"
    allocations = {
      (google_app_engine_standard_app_version.gcp-app-engine-sample-v1.version_id) = 0.50
      (google_app_engine_standard_app_version.gcp-app-engine-sample-v2.version_id) = 0.50
    }
  }
}