//outputs Access Key to other modules
output "AppServiceID" {
  value = azurerm_linux_web_app.appservice.id
  sensitive = true
}