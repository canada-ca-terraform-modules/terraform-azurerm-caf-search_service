# test_dependencies.tf
# Self-contained dependency resources, owned entirely by this harness.
#
# Deliberately NOT reusing any shared/production resource group: writing into
# a shared RG usually requires elevated, non-sandbox permissions. A dedicated
# throwaway RG here needs only Contributor on the sandbox subscription and
# can never collide with or affect any production resource.
#
# terraform-azurerm-caf-search_service doesn't require a virtual_network/
# subnet input for this harness's default path (private_endpoint is out of
# scope here) - no vnet dependency is created.

resource "azurerm_resource_group" "live_test" {
  # PR-number suffix keeps two concurrently open PRs against this module from
  # colliding on the same sandbox resource group.
  name     = "${var.env}-caf-search-service-live-test-${var.pr_number}-rg"
  location = var.location

  # pr-number tag: lets the nightly orphan sweeper find this RG by tag and
  # match it back to a PR, independent of naming convention.
  # repository tag: the sandbox subscription is shared across module repos,
  # so the sweeper must scope its `pr-number` matches to only this repo's
  # own PRs - otherwise a PR number collision across repos could
  # misclassify (or destroy) another repo's live resource group.
  tags = {
    "pr-number"  = var.pr_number
    "repository" = var.repository
  }
}

locals {
  # terraform-azurerm-caf-search_service expects resource_groups as a
  # purpose-keyed map (var.resource_groups[var.SearchService.resource_group].name).
  resource_groups = {
    Project = {
      name = azurerm_resource_group.live_test.name
    }
  }
}
