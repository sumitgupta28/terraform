
variable "AWS_S3_BUCKET_NAME" {
  default = "sumitgupta28-s3-bucket"
}

variable "GCP_BUCKET_NAME" {
  default = "sumitgupta28-awss3-backup-bucket"
}


## Create S3 Bucket
resource "aws_s3_bucket" "sumitgupta28-s3-bucket" {
  bucket = var.AWS_S3_BUCKET_NAME
  acl    = "private"

  tags = {
    Name        = "sumitgupta28-s3-backend"
    Environment = "Dev"
  }
}

## upload few files on S3 bucket
resource "aws_s3_bucket_object" "s3_bucket_upload" {
  for_each = fileset("images/", "*")
  bucket   = aws_s3_bucket.sumitgupta28-s3-bucket.id
  key      = each.value
  source   = "images/${each.value}"
  etag     = filemd5("images/${each.value}")
}


data "google_storage_transfer_project_service_account" "default" {
  project = var.GCP_PROJECT_ID
}



resource "google_storage_bucket" "s3-backup-bucket" {
  name                        = var.GCP_BUCKET_NAME
  storage_class               = "NEARLINE"
  location                    = "US" ## multi Region
  force_destroy               = true
  project                     = var.GCP_PROJECT_ID
  uniform_bucket_level_access = true

}

resource "google_storage_bucket_iam_member" "s3-backup-bucket" {
  bucket     = google_storage_bucket.s3-backup-bucket.name
  role       = "roles/storage.admin"
  member     = "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
  depends_on = [google_storage_bucket.s3-backup-bucket]
}

resource "google_storage_transfer_job" "s3-bucket-transfer-job" {
  description = "Job to trasfer images from S3 bucket"
  project     = var.GCP_PROJECT_ID

  depends_on = [
    google_storage_bucket.s3-backup-bucket,
    aws_s3_bucket.sumitgupta28-s3-bucket,
    aws_s3_bucket_object.s3_bucket_upload
  ]
  ## transfer specification
  transfer_spec {
    ## source Bucket
    aws_s3_data_source {
      bucket_name = var.AWS_S3_BUCKET_NAME
      aws_access_key {
        access_key_id     = var.AWS_ACCESS_KEY
        secret_access_key = var.AWS_SECRET_KEY
      }
    }

    transfer_options {
      delete_objects_unique_in_sink = false
    }

    ## Destination Bucket
    gcs_data_sink {
      bucket_name = google_storage_bucket.s3-backup-bucket.name
    }
  }

  schedule {
    schedule_start_date {
      year  = 2021
      month = 03
      day   = 31
    }
  }
}



output "gpc-bucket" {
  value = google_storage_bucket.s3-backup-bucket.url
}

output "aws-bucket" {
  value = aws_s3_bucket.sumitgupta28-s3-bucket.arn
}