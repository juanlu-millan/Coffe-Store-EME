terraform {
  required_providers {
    fly = {
      source = "fly-examples/fly"
      version = "~> 0.1"
    }
  }
}

provider "fly" {
  api_token = var.fly_api_token
}

variable "fly_api_token" {
  type = string
  description = "Token de Fly.io"
}


resource "fly_app" "my_app" {
  name   = "mi-app"
  org    = "personal"
  region = "iad"
}

resource "fly_deployment" "my_app_deploy" {
  app = fly_app.my_app.name
  image = "docker.io/usuario/mi-app:latest"
}
