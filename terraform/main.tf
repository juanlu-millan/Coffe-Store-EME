# Artifact Registry (Docker)
resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.artifact_repo
  format        = "DOCKER"
  description   = "Docker repo for FastAPI"
}

# CI Service Account
resource "google_service_account" "ci" {
  account_id   = "ci-deployer"
  description  = "CI service account to push images and deploy"
}

# Grant roles (artifact push + cloud run admin)
resource "google_project_iam_member" "artifact_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.ci.email}"
}

resource "google_project_iam_member" "run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.ci.email}"
}

# Cloud Run service
resource "google_cloud_run_service" "fastapi" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.docker_repo.repository_id}/${var.service_name}:${var.image_tag}"
        ports {
          container_port = 8080
        }
        env {
          name  = "PORT"
          value = "8080"
        }
      }
    }
  }

  traffic {
    percent = 100
    latest_revision = true
  }
}

# Make service public (para pruebas; en prod usar IAM controlado)
resource "google_cloud_run_service_iam_member" "invoker" {
  service  = google_cloud_run_service.fastapi.name
  location = google_cloud_run_service.fastapi.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
