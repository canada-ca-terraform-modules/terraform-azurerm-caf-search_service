output "SearchService-object" {
  description = "Outputs the entire Search Service object"
  value = azurerm_search_service.search_service
}

output "ss_id" {
  description = "Outputs the ID of the Search Service"
  value = azurerm_search_service.search_service.id
}

output "ss_name" {
  description = "Outputs the name of the Search Service"
  value = azurerm_search_service.search_service.name
}