mock_provider "azurerm" {}

variables {
  resource_groups = {
    Project = { name = "rg-project", id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-project" }
  }
  subnets              = {}
  private_dns_zone_ids = {}
  tags                 = {}
  env                  = "Dev"
  group                = "OPS"
  project              = "CORE"
  userDefinedString    = "test"
}

# Step 1: simulate the currently-deployed resource (pre-upgrade inputs only)
run "baseline_apply" {
  command = apply
  variables {
    SearchService = {
      resource_group = "Project"
      sku            = "standard"
    }
  }
  assert {
    condition     = azurerm_search_service.search_service.name == "dev-ops-core-test-ss"
    error_message = "Baseline apply: unexpected resource name"
  }
}

# Step 2: plan upgraded code (new args added) against that state
run "upgrade_plan_no_replacement" {
  command = plan
  variables {
    SearchService = {
      resource_group             = "Project"
      sku                        = "standard"
      network_rule_bypass_option = "AzureServices"
    }
  }
  assert {
    condition     = azurerm_search_service.search_service.name == "dev-ops-core-test-ss"
    error_message = "Resource name must be unchanged after upgrade"
  }
  assert {
    condition     = azurerm_search_service.search_service.network_rule_bypass_option == "AzureServices"
    error_message = "network_rule_bypass_option must be set"
  }
}
