### Source Topic
resource "google_pubsub_topic" "topic-dataflow-job-source" {
  name = "dataflow-job-source-topic"
}
### Source Subscription
resource "google_pubsub_subscription" "dataflow-job-source-topic-subscription" {
  name       = "dataflow-job-source-topic-subscription"
  topic      = google_pubsub_topic.topic-dataflow-job-source.name
  ack_deadline_seconds = 500
  depends_on = [google_pubsub_topic.topic-dataflow-job-source]
}

### Destination Topic
resource "google_pubsub_topic" "topic-dataflow-job-destination" {
  name = "dataflow-job-destination-topic"
}

### Destination Subscription
resource "google_pubsub_subscription" "dataflow-job-destination-topic-subscription" {
  name       = "dataflow-job-destination-topic-subscription"
  topic      = google_pubsub_topic.topic-dataflow-job-destination.name
  ack_deadline_seconds = 500
  depends_on = [google_pubsub_topic.topic-dataflow-job-destination]
}

### Temp Bucket
resource "google_storage_bucket" "temp-working-bucket" {
  name                        = "sumitgupta28-temp-working-bucket"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
  storage_class               = "STANDARD"
}
### Temp Bucket with temp folder
resource "google_storage_bucket_object" "temp-working-bucket-folder" {
  name    = "temp/"
  content = "Not really a directory, but it's empty."
  bucket  = google_storage_bucket.temp-working-bucket.name
}

output "google_storage_bucket_object-name" {
  value = google_storage_bucket_object.temp-working-bucket-folder.self_link
}

## dataflow job
resource "google_dataflow_job" "pubsub-pubsub-stream" {
  name              = "pubsub-pubsub-stream-1"
  template_gcs_path = "gs://dataflow-templates-us-central1/latest/Cloud_PubSub_to_Cloud_PubSub"
  temp_gcs_location = var.TEMP_BUCKET_NAME
  region            = var.GCP_REGION
  parameters = {
    "inputSubscription"  = google_pubsub_subscription.dataflow-job-source-topic-subscription.path
    "outputTopic" = google_pubsub_topic.topic-dataflow-job-destination.id
  }
  depends_on = [
    google_pubsub_topic.topic-dataflow-job-source,
    google_pubsub_subscription.dataflow-job-source-topic-subscription,
    google_pubsub_topic.topic-dataflow-job-destination,
  ]
  labels = {
    "name" = "pubsub-pubsub-stream"
  }
  
  machine_type = "n1-standard-2"
  max_workers  = 1
  on_delete    = "cancel"
}


output "dataflow-job-source-topic-subscription-path" {
  value = google_pubsub_subscription.dataflow-job-source-topic-subscription.path
}

output "google_pubsub_topic-topic-dataflow-job-destination-id" {
  value = google_pubsub_topic.topic-dataflow-job-destination.id
}
