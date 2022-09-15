output "service_url" {
  value       = [for app in google_cloud_run_service.my-service : app.status[0].url]
  description = "URL de mi servicio"
}
