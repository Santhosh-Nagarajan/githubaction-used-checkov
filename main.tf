# ######## IAM Roles & Permissions ##############

# data "google_iam_policy" "admin" {
#   binding {
#     role = "roles/viewer"
#     members = [
#       "jane@example.com",
#     ]
#   }
# }

# resource "google_cloud_run_service_iam_policy" "policy" {
#   location    = google_cloud_run_service.example_service.location
#   project     = google_cloud_run_service.example_service.project
#   service     = google_cloud_run_service.example_service.name
#   policy_data = data.google_iam_policy.admin.policy_data
# }

############################################################



resource "google_cloud_run_service" "example_service" {
  name     = var.service-name
  location = var.region
  template {
    spec {
      containers {
        ports {
          container_port = var.port
        }
        image = var.image-name
        env {
          name  = var.env-name
          value = var.value
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}


