output "principal_id" {
  value = azurerm_app_service.app.identity[0].principal_id
}