terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "~> 0.0.21"
    }
  }
}

provider "fly" {}

resource "fly_app" "fastapi" {
  name = var.app_name
  org  = "personal"
}

resource "fly_machine" "fastapi" {
  app     = fly_app.fastapi.name
  region  = var.region
  image   = "fastapi-app:latest"

  env = {
    PORT = "8080"
  }
}
