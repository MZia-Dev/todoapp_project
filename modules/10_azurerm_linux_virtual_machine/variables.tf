variable "linux_vm" {
  type = map(object({
    # ---------------- Required ----------------
    name                = string
    location            = string
    resource_group_name = string
    size                = string

    # NIC info (ID will be fetched via data block)
    nic_name = string
    nic_rg   = string

    # Key Vault integration
    kv_name         = string
    kv_rg           = string
    username_secret = string
    password_secret = string

    # ---------------- Optional ----------------


    image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    os_disk = object({
      caching              = optional(string)
      storage_account_type = optional(string)
      disk_size_gb         = optional(number)
    })

    identity_type = optional(string)

    tags = optional(map(string))
  }))
}