# config/search_service.tfvars
# One representative real-usage fixture: standard SKU, system-assigned
# identity, no private_endpoint fan-out (out of scope for this harness).

SearchService = {
  resource_group = "Project"
  sku            = "standard"

  identity = {
    type = "SystemAssigned"
  }

  network_rule_bypass_option = "AzureServices"
}
