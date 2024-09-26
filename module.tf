resource "azurerm_search_service" "search_service" {
  name                = local.searchservice-name
  location            = var.location
  resource_group_name = local.resource_group_name
  sku                 = var.SearchService.sku

  # Optional parameters
  public_network_access_enabled            = try(var.SearchService.public_network_access_enabled, false)
  allowed_ips                              = try(var.SearchService.public_network_access_enabled, null)
  local_authentication_enabled             = try(var.SearchService.local_authentication_enabled, true)
  authentication_failure_mode              = try(var.SearchService.authentication_failure_mode, null)
  customer_managed_key_enforcement_enabled = try(var.SearchService.customer_managed_key_enforcement_enabled, false)
  hosting_mode                             = try(var.SearchService.hosting_mode, null)
  partition_count                          = try(var.SearchService.partition_count, 1)
  replica_count                            = try(var.SearchService.replica_count, null)
  semantic_search_sku                      = try(var.SearchService.semantic_search_sku, null)

  tags = merge(var.tags, try(var.SearchService.tags, {}))

  dynamic "identity" {
    for_each = try(var.SearchService.identity, null) != null ? [1] : []
    content {
      type = try(var.SearchService.identity.type, null)
    }
  }
}

module "private_endpoint" {
  source   = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-private_endpoint.git?ref=v1.0.1"
  for_each = try(var.SearchService.private_endpoint, {})
 
  name                           = "${local.searchservice-name}-${each.key}"
  location                       = var.location
  resource_groups                = var.resource_groups
  subnets                        = var.subnets
  private_connection_resource_id = azurerm_search_service.search_service.id
  private_endpoint               = each.value
  private_dns_zone_ids           = var.private_dns_zone_ids
  tags                           = var.tags
}