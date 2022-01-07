resource "google_pubsub_topic" "topic" {
  name = "job-topic"
}

resource "google_cloud_scheduler_job" "job" {
  name        = "demo-job"
  description = "demo job"
  schedule    = "* * * * *"
  time_zone   = "America/Mexico_City"

  pubsub_target {
    # topic.id is the topic's full resource name.
    topic_name = google_pubsub_topic.topic.id
    data       = base64encode("test")
  }
}

resource "google_pubsub_subscription" "demo-sub" {
  name  = "demo-subscription"
  topic = google_pubsub_topic.topic.id
}