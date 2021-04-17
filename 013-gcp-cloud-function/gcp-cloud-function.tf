
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
  name   = "pubsub-function.zip"
  source = "code-zip/pubsub-function.zip"
  bucket = var.GCP_BUCKET_NAME
  depends_on = [
    google_storage_bucket.code-bucket
  ]
}

resource "google_pubsub_topic" "pub-sub-transaction-topic" {
  name = "transaction-topic"

  labels = {
    name = "transaction-topic"
  }

}

resource "google_cloudfunctions_function" "function-test-pubsub-topic" {
  name        = "function-test-pubsub-topic"
  description = "Pub Sub topic Message Print"
  runtime     = "java11"

  timeout = 60
  entry_point           = "com.demo.gcp.GcpPubSubFunctionDemoApplication"
  max_instances = 1
  source_archive_bucket     = google_storage_bucket.code-bucket.name
  source_archive_object     = google_storage_bucket_object.application-zip-copy.name

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource = google_pubsub_topic.pub-sub-transaction-topic.id
  }
  available_memory_mb   = 128

  depends_on = [
    google_storage_bucket_object.application-zip-copy
  ]
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function-test-pubsub-topic.project
  region         = google_cloudfunctions_function.function-test-pubsub-topic.region
  cloud_function = google_cloudfunctions_function.function-test-pubsub-topic.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}