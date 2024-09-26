locals {
  resource_group_name = strcontains(var.SearchService.resource_group, "/resourceGroups/") ? regex("[^\\/]+$", var.SearchService.resource_group) : var.resource_groups[var.SearchService.resource_group].name
}