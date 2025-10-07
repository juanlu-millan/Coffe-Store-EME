variable "fly_api_token" {
  description = "Token de autenticación de Fly.io"
  type        = string
  sensitive   = true
}

variable "app_name" {
  description = "Nombre de la app en Fly.io"
  type        = string
  default     = "coffee-eme"
}

variable "region" {
  description = "Región donde se desplegará la app"
  type        = string
  default     = "lhr"
}
