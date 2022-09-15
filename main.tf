locals {
  services = {
    hola-mundo  = "gcr.io/cloudrun/hello"
    hola-mundo2 = "gcr.io/cloudrun/hello"
  }
}

resource "google_cloud_run_service" "my-service" { #my-service["hola-mundo"]
  for_each = local.services
  name     = each.key
  template {
    spec {
      containers {
        image = each.value
      }
    }
  }
  traffic {
    percent         = 90
    latest_revision = true
  }
  location = var.region
  depends_on = [
    google_project_service.cloud_run_api
  ]
}

# Service API
resource "google_project_service" "cloud_run_api" {
  service            = "run.googleapis.com"
  disable_on_destroy = true
}

resource "google_cloud_run_service_iam_member" "public" {
  for_each = local.services
  service  = google_cloud_run_service.my-service[each.key].name
  location = google_cloud_run_service.my-service[each.key].location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
