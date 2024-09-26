SearchService = {
  test = {
    resource_group = "Project"
    sku            = "standard"

    # Optional: Uncomment if you want to set any of these parameters to values other than the defaults below. 
    # public_network_access_enabled            = false
    # allowed_ips                              = "" #only applied if the public_network_access_enabled field has been set
    # local_authentication_enabled             = true
    # authentication_failure_mode              = "http403" #can only be configured when using local_authentication_enabled is set to true
    # customer_managed_key_enforcement_enabled = false
    # hosting_mode                             = default #can only be configured when sku is set to standard3
    # partition_count                          = 1 #when hosting_mode is set to highDensity the maximum number of partitions allowed is 3
    # replica_count                            = 1 #This field cannot be set when using a free sku
    # semantic_search_sku                      = "standard" #cannot be defined if your Search Services sku is set to free
    
    # identity {
    # type =SystemAssigned #The only possible value is SystemAssigned
    # }

    # Optional: Comment this out if you don't need a private endpoint
    private_endpoint = {
      ss = {                       # Key defines the userDefinedstring
        resource_group    = "Project"     # Required: Resource group name, i.e Project, Management, DNS, etc, or the resource group ID
        subnet            = "OZ"         # Required: Subnet name, i.e OZ,MAZ, etc, or the subnet ID
        subresource_names = ["searchService"] # Required: Subresource name determines to what service the private endpoint will connect to. see: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource for list of subresrouce
        # local_dns_zone    = "privatelink.blob.core.windows.net" # Optional: Name of the local DNS zone for the private endpoint
      }
    }
  }
}
