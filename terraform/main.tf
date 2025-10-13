###########################################################
# Main Terraform file para Coffee EME
# Despliega:
#  - Artifact Registry (Docker)
#  - Service Account para CI/CD
#  - Roles IAM necesarios
#  - Cloud Run service con URL pública
###########################################################

# Artifact Registry para Docker
resource "google_artifact_registry_repository" "docker_repo" {
  location      = "europe-west1"
  repository_id = "coffee-eme-repo"
  format        = "DOCKER"
  description   = "Docker repo for Coffee EME"
}

# Service Account para CI/CD
resource "google_service_account" "ci" {
  account_id   = "ci-deployer"
  display_name = "CI/CD Service Account"
}

# IAM roles para la Service Account
resource "google_project_iam_member" "artifact_writer" {
  project = "coffee-eme"
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.ci.email}"
}

resource "google_project_iam_member" "run_admin" {
  project = "coffee-eme"
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.ci.email}"
}

# Cloud Run Service
resource "google_cloud_run_service" "coffee_eme" {
  name     = "coffee-eme"
  location = "europe-west1"

  template {
    spec {
      containers {
        image = "europe-west1-docker.pkg.dev/coffee-eme/coffee-eme-repo/coffee-eme:v10"
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Hacer el servicio público para pruebas
resource "google_cloud_run_service_iam_member" "invoker" {
  service  = google_cloud_run_service.coffee_eme.name
  location = google_cloud_run_service.coffee_eme.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
