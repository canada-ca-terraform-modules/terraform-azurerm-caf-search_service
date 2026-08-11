mock_provider "azurerm" {}

variables {
  resource_groups = {
    Project = { name = "rg-project", id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-project" }
  }
  subnets = {
    OZ = { name = "snet-oz", id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-project/providers/Microsoft.Network/virtualNetworks/vnet/subnets/snet-oz" }
  }
  private_dns_zone_ids = {}
  tags                 = {}
  env                  = "Dev"
  group                = "OPS"
  project              = "CORE"
  userDefinedString    = "test"
}

run "naming_convention" {
  command = plan
  variables {
    SearchService = {
      resource_group = "Project"
      sku            = "standard"
    }
  }
  assert {
    condition     = azurerm_search_service.search_service.name == "dev-ops-core-test-ss"
    error_message = "Name must follow {env}-{group}-{project}-{userDefinedString}-ss convention"
  }
}

run "name_override" {
  command = plan
  variables {
    SearchService = {
      resource_group = "Project"
      sku            = "standard"
      name           = "existing-search-service"
    }
  }
  assert {
    condition     = azurerm_search_service.search_service.name == "existing-search-service"
    error_message = "Explicit name override must take priority over the generated name"
  }
}

run "default_values" {
  command = plan
  variables {
    SearchService = {
      resource_group = "Project"
      sku            = "standard"
    }
  }
  assert {
    condition     = azurerm_search_service.search_service.public_network_access_enabled == false
    error_message = "public_network_access_enabled must default to false"
  }
  assert {
    condition     = azurerm_search_service.search_service.local_authentication_enabled == true
    error_message = "local_authentication_enabled must default to true"
  }
  assert {
    condition     = azurerm_search_service.search_service.customer_managed_key_enforcement_enabled == false
    error_message = "customer_managed_key_enforcement_enabled must default to false"
  }
  assert {
    condition     = azurerm_search_service.search_service.partition_count == 1
    error_message = "partition_count must default to 1"
  }
  assert {
    condition     = azurerm_search_service.search_service.network_rule_bypass_option == null
    error_message = "network_rule_bypass_option must default to null"
  }
  assert {
    condition     = length(azurerm_search_service.search_service.identity) == 0
    error_message = "identity block must not be emitted when omitted"
  }
}

run "network_rule_bypass_option" {
  command = plan
  variables {
    SearchService = {
      resource_group             = "Project"
      sku                        = "standard"
      network_rule_bypass_option = "AzureServices"
    }
  }
  assert {
    condition     = azurerm_search_service.search_service.network_rule_bypass_option == "AzureServices"
    error_message = "network_rule_bypass_option must be passed through"
  }
}

run "identity_system_assigned" {
  command = plan
  variables {
    SearchService = {
      resource_group = "Project"
      sku            = "standard"
      identity = {
        type = "SystemAssigned"
      }
    }
  }
  assert {
    condition     = tolist(azurerm_search_service.search_service.identity)[0].type == "SystemAssigned"
    error_message = "identity.type must be passed through"
  }
  assert {
    condition     = tolist(azurerm_search_service.search_service.identity)[0].identity_ids == null
    error_message = "identity_ids must default to null when not supplied"
  }
}

run "identity_user_assigned" {
  command = plan
  variables {
    SearchService = {
      resource_group = "Project"
      sku            = "standard"
      identity = {
        type         = "UserAssigned"
        identity_ids = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-project/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mid"]
      }
    }
  }
  assert {
    condition     = tolist(tolist(azurerm_search_service.search_service.identity)[0].identity_ids)[0] == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-project/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mid"
    error_message = "identity_ids must be passed through for UserAssigned identity"
  }
}

run "allowed_ips" {
  command = plan
  variables {
    SearchService = {
      resource_group                = "Project"
      sku                           = "standard"
      public_network_access_enabled = true
      allowed_ips                   = ["1.2.3.4", "5.6.7.0/24"]
    }
  }
  assert {
    condition     = length(azurerm_search_service.search_service.allowed_ips) == 2
    error_message = "allowed_ips must be passed through as a list"
  }
}

run "private_endpoint" {
  command = plan
  variables {
    SearchService = {
      resource_group = "Project"
      sku            = "standard"
      private_endpoint = {
        ss = {
          resource_group    = "Project"
          subnet            = "OZ"
          subresource_names = ["searchService"]
        }
      }
    }
  }
  assert {
    condition     = length(module.private_endpoint) == 1
    error_message = "private_endpoint child module must be created when configured"
  }
}
