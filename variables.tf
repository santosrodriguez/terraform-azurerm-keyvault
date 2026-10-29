variable "location" {
  type = string
  default = "eastus"
}

variable "enable_rbac_authorization" {
  type = bool
  default = true
}

variable "environment" {
  type = string
}

variable "eventhub_authorization_rule_id" {
  type        = string
  description = "The Event Hub authorization rule ID for diagnostic settings."
  default     = "/subscriptions/56bdaed4-70cf-4a28-8fb8-0efc135bb29f/resourceGroups/LOGS_RG/providers/Microsoft.EventHub/namespaces/evh-sharedsvcseastus/authorizationRules/RootManageSharedAccessKey"
}

variable "eventhub_name" {
  type        = string
  description = "The Event Hub name for diagnostic settings."
  default     = "cs-resource_resourcelogs"
}

variable "network_acls" {
  type = object({
    bypass = optional(string, "None")
    default_action = optional(string, "Deny")
  })
  default = { }
}

variable "private_endpoint_dns_zone_ids" {
  type = list(string)
  default = [ "/subscriptions/56bdaed4-70cf-4a28-8fb8-0efc135bb29f/resourceGroups/rg-azuredns-prd-01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net" ]
}

variable "private_endpoint_dns_zone_group_name" {
  type = string
  default = "default"
}

variable "private_endpoint_subnet_id" {
  type = string
}

variable "public_network_access_enabled" {
  type = bool
  default = false
}

variable "purge_protection_enabled" {
  type = bool
  default = true
}

variable "resource_group_name" {
  type = string
}

variable "sku_name" {
  type = string
  default = "standard"
}

variable "solution_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "tenant_id" {
  type = string
  default = "1d926b6a-bdf4-4b09-9a04-7410a9382da1"
}
