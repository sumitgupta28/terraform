resource "google_pubsub_topic" "topic" {
  name = "dataflow-job1"
}

resource "google_storage_bucket" "bucket1" {
  name          = "tf-test-bucket1"
  force_destroy = true
}

resource "google_storage_bucket" "templates-bucket" {
  name          = "tf-templates-bucket-bucket2"
  force_destroy = true
}

resource "google_dataflow_job" "pubsub_stream" {
  name                    = "tf-test-dataflow-job1"
  template_gcs_path       = "gs://sumitgupat28-dataflow-bucket/templates/Stream_GCS_Text_to_Cloud_PubSub"
  temp_gcs_location       = "gs://sumitgupat28-dataflow-bucket/tmp_dir"
  enable_streaming_engine = true
  parameters = {
    inputFilePattern = "${google_storage_bucket.bucket1.url}/*.json"
    outputTopic      = google_pubsub_topic.topic.id
  }
  transform_name_mapping = {
    name = "test_job"
    env  = "test"
  }

  machine_type = "n1-standard-2"
  max_workers = 2
  on_delete = "cancel"
}