variable "SearchService" {
  description = "Object containing all Search Service"
  type        = any
  default     = {}
}

module "SearchService" {
  source   = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-search_service?ref=v1.0.0"
  for_each = var.SearchService

  userDefinedString    = each.key
  env                  = var.env
  group                = var.group
  project              = var.project
  resource_groups      = local.resource_groups_all
  subnets              = local.subnets
  SearchService        = each.value
  private_dns_zone_ids = local.Project-dns-zone
  tags                 = var.tags
}