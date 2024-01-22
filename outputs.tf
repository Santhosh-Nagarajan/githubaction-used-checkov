output "cloud-run-url" {
  value = google_cloud_run_service.example_service.status[0].url
}
output "cloud-run-id" {
  value = google_cloud_run_service.example_service.id
}
