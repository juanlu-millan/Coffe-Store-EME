terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.4.0"
    }
  }
}

provider "google" {
  credentials = file("terraform-key.json")
  project     = "coffee-eme"
  region      = "europe-west1"
}

