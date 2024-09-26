<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | github.com/canada-ca-terraform-modules/terraform-azurerm-caf-private_endpoint.git | v1.0.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_search_service.search_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_SearchService"></a> [SearchService](#input\_SearchService) | Object that will contain all parameters for Search Service | `any` | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | (Required) Env value for the name of the resource | `string` | n/a | yes |
| <a name="input_group"></a> [group](#input\_group) | (Required) Group value for the name of the resource | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location for the resource | `string` | `"canadacentral"` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | Object containing private DNS zone IDs for the target project | `any` | `{}` | no |
| <a name="input_project"></a> [project](#input\_project) | (Required) Project value for the name of the resource | `string` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | Resouce group object containing a list of resource group in the target project | `any` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet object containing a list of subnets in the target project | `any` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Maps of tags that will be applied to the resource | `map(string)` | `{}` | no |
| <a name="input_userDefinedString"></a> [userDefinedString](#input\_userDefinedString) | (Required) UserDefinedString value for the name of the resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_SearchService-object"></a> [SearchService-object](#output\_SearchService-object) | Outputs the entire Search Service object |
| <a name="output_ss_id"></a> [ss\_id](#output\_ss\_id) | Outputs the ID of the Search Service |
| <a name="output_ss_name"></a> [ss\_name](#output\_ss\_name) | Outputs the name of the Search Service |
<!-- END_TF_DOCS -->