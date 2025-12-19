# ---------------- NIC Lookup ----------------
data "azurerm_network_interface" "nic_ids" {
  for_each = var.linux_vm

  name                = each.value.nic_name
  resource_group_name = each.value.nic_rg
}

# ---------------- Key Vault Lookup ----------------
data "azurerm_key_vault" "kv" {
  for_each = var.linux_vm

  name                = each.value.kv_name
  resource_group_name = each.value.kv_rg
}

# ---------------- Username Secret ----------------
data "azurerm_key_vault_secret" "vm_admin_username" {
  for_each     = var.linux_vm
  name         = each.value.username_secret
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

# ---------------- Password Secret ----------------
data "azurerm_key_vault_secret" "vm_admin_password" {
  for_each     = var.linux_vm
  name         = each.value.password_secret
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}