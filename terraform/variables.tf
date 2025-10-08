variable "project_id" { type = string }
variable "region"    { type = string, default = "europe-west1" }
variable "credentials_path" { type = string, default = "~/.gcp/sa-key.json" }
variable "artifact_repo" { type = string, default = "fastapi-repo" }
variable "service_name" { type = string, default = "fastapi-service" }
variable "image_tag" { type = string, default = "v1" }
