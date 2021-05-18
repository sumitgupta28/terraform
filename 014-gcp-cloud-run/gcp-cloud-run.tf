resource "google_cloud_run_service" "docker-sample-app" {
  name     = "docker-sample-app-service"
  location = var.GCP_REGION
  project  = var.GCP_PROJECT_ID
  

  template {
    spec {
      containers {
        image = "us.gcr.io/gcp-learning-project-312006/docker-sample-app@sha256:8fab095903e760793211d7d6676408dc4594c1021b236a0db4ea67aa221d5091"
      }
    }
    metadata {
      name = "docker-sample-app-service-green"
    }


  }
  metadata {
    annotations = {
      generated-by = "terraform"
    }

  }
  traffic {
    percent         = 100
    latest_revision = true
  }

}

### this for Cloud Run Service with Noauth
data "google_iam_policy" "docker-sample-app-noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "docker-sample-app-noauth-iam-policy" {
  location = google_cloud_run_service.docker-sample-app.location
  project  = google_cloud_run_service.docker-sample-app.project
  service  = google_cloud_run_service.docker-sample-app.name

  policy_data = data.google_iam_policy.docker-sample-app-noauth.policy_data
}


output "url" {
  value = google_cloud_run_service.docker-sample-app.status[0].url
}