resource "google_cloud_run_service" "cloudrun_symfony" {
  name     = var.gcp_cloudrun_service_name
  location = var.gcp_region

  template {
    spec {
      containers {
        image = "gcr.io/${var.gcp_project_id}/${var.gcp_image_name}"
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.cloudrun_symfony.location
  project     = google_cloud_run_service.cloudrun_symfony.project
  service     = google_cloud_run_service.cloudrun_symfony.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
