resource "google_pubsub_topic" "pub-sub-transaction-topic" {
  name = "transaction-topic"

  labels = {
    name = "transaction-topic"
  }
}


resource "google_pubsub_subscription" "pub-sub-transaction-topic-pull-subscription" {
  name                 = "transaction-subscription"
  topic                = google_pubsub_topic.pub-sub-transaction-topic.id
  ack_deadline_seconds = 10
  # 20 minutes
  message_retention_duration = "1200s"
  retain_acked_messages      = true
  enable_message_ordering    = true
  expiration_policy {
    ttl = "300000.5s"
  }
  labels = {
    name = "transaction-subscription"
  }
}

resource "google_pubsub_subscription" "pub-sub-transaction-topic-pull-notification" {
  name                 = "transaction-notification-subscription"
  topic                = google_pubsub_topic.pub-sub-transaction-topic.id
  ack_deadline_seconds = 10
  # 20 minutes
  message_retention_duration = "1200s"
  retain_acked_messages      = true
  enable_message_ordering    = true
  expiration_policy {
    ttl = "300000.5s"
  }
  labels = {
    name = "transaction-notification-subscription"
  }
}