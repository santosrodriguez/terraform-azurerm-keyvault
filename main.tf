terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

resource "random_string" "suffix" {
  length = 4
  upper = false
  numeric = true
  special = false
  lower = false
}

data "azurecaf_name" "kv_name" {
  resource_type = "azurerm_key_vault"
  suffixes = [ var.solution_name, var.location, var.environment, random_string.suffix.result ]
}

resource "azurerm_key_vault" "kv" {
  location = var.location
  resource_group_name = var.resource_group_name
  name = data.azurecaf_name.kv_name.result
  sku_name = var.sku_name
  tenant_id = var.tenant_id
  public_network_access_enabled = var.public_network_access_enabled
  enable_rbac_authorization = var.enable_rbac_authorization
  purge_protection_enabled = var.purge_protection_enabled
  soft_delete_retention_days = 30
  tags = var.tags
  network_acls {
    bypass = var.network_acls.bypass
    default_action = var.network_acls.default_action
  }
}

resource "azurerm_private_endpoint" "kv_pep" {
  name = "pe-${azurerm_key_vault.kv.name}"
  location = azurerm_key_vault.kv.location
  subnet_id = var.private_endpoint_subnet_id
  resource_group_name = var.resource_group_name
  private_service_connection {
    is_manual_connection = false
    name = "pe-connection-${azurerm_key_vault.kv.name}"
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names = [ "vault" ]
  }
  private_dns_zone_group {
    private_dns_zone_ids = var.private_endpoint_dns_zone_ids
    name = var.private_endpoint_dns_zone_group_name
  }
}

resource "azurerm_monitor_diagnostic_setting" "kv_diag" {
  name = "diag-${azurerm_key_vault.kv.name}"
  target_resource_id = azurerm_key_vault.kv.id
  eventhub_name = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  enabled_log {
    category = "AuditEvent"
  }
}
