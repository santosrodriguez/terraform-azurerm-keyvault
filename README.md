# Azure Key Vault Terraform Module

## Introduction
Deploy secure, production-ready Azure Key Vaults with Private Endpoint integration using Terraform.

## Usage

```hcl
module "key_vault" {
  source = "caresource.pe.jfrog.io/shared-tfmodules-internal__security/keyvault/azurerm"
  version = "0.1.2"
  environment = var.environment
  resource_group_name = "rg-${var.solution_name}-keyvault-${var.location}$-${var.environment}-01"
  private_endpoint_subnet_id = "/subscriptions/../resourceGroups/../providers/Microsoft.Network/virtualNetworks/../subnets/.."
  solution_name = var.solution_name
}
```

## Inputs
| Name                                | Type           | Description                                       | Default    |
|-------------------------------------|----------------|---------------------------------------------------|------------|
| resource_group_name                 | string         | Resource group name                               | n/a        |
| enable_rbac_authorization           | bool           | Azure region                                      | true       |
| environment                         | string         | Environment Name (dev, int, etc...)               | n/a        |
| eventhub_authorization_rule_id      | string         | Event Hub Authorization Rule ID for logging       | "/subscriptions/56bdaed4-70cf-4a28-8fb8-0efc135bb29f/resourceGroups/LOGS_RG/providers/Microsoft.EventHub/namespaces/evh-sharedsvcseastus/authorizationRules/RootManageSharedAccessKey" |
| eventhub_name                       | string         | Name of eventhub                                  | "cs-resource_resourcelogs" |
| location                            | string         | Location to deploy resources                      | "eastus" |
| network_acls                        | object         | Networking rules                                  | {<br />&nbsp;&nbsp;bypass = "None"<br />&nbsp;&nbsp;default_action = "Deny"<br />} |
| private_endpoint_dns_zone_ids      | list(string)   | DNS Zone ID for private endpoint configuration    | [ "/subscriptions/56bdaed4-70cf-4a28-8fb8-0efc135bb29f/resourceGroups/rg-azuredns-prd-01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net" ] |
| private_endpoint_dns_zone_group_name | string       | DNS Zone Group Name                                | "default" |
| private_endpoint_subnet_id          | string        | Private Endpoint Subnet to use | n/a |
| purge_protection_enabled            | bool          | Is purge protection enabled?                       | false     |
| sku_name                            | string        | Type of SKU to use                                 | "standard" |
| solution_name                       | string        | Name of project or initiative                      | n/a |
| tags                                | map(string)   | Tags to add to the resource                        | n/a |

## Outputs
| Name                                 | Description                           |
|---------------------------------------|---------------------------------------|
| key_vault                    | Key Vault Resource           |

## Features

- Secure, configurable key vault creation
- Private Endpoint integration
- Tagging support
- Logs sent to Splunk

## Requirements

- Terraform >= 1.4.0
- AzureRM >= 3.0
