output "app_name" {
  value = fly_app.fastapi.name
}

output "app_url" {
  value = "https://${fly_app.fastapi.name}.fly.dev"
}