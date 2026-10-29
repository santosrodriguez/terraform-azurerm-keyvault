output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}

output "managed_identity_principal_id" {
  value = azurerm_key_vault.kv.identity[0].principal_id
}
