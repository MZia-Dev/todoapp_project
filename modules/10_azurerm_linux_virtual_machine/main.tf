resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.linux_vm

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.size

  network_interface_ids = [
    data.azurerm_network_interface.nic_ids[each.key].id
  ]


  # Username + Password from Key Vault
  admin_username = data.azurerm_key_vault_secret.vm_admin_username[each.key].value
  admin_password = data.azurerm_key_vault_secret.vm_admin_password[each.key].value


  disable_password_authentication = false

  # zone = each.value.zone

  source_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
  }

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  identity {
    type = each.value.identity_type
  }

  tags = each.value.tags
}
