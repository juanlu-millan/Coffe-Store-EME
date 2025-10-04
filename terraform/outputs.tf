output "app_name" {
  value = fly_app.my_app.name
}

output "app_url" {
  value = fly_app.my_app.hostname
}
