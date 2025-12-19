variable "rg" {
type = map(object({
        name     = string                   
        location = string                   
        managed_by = optional(string)       
        tags     = optional(map(string))    
    }))
}
variable "vnet" {
  description = "Map of Virtual Network configurations"

  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    address_space           = list(string)
    dns_servers             = optional(list(string))
    bgp_community           = optional(string)
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    tags                    = optional(map(string))

    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))
  }))
}



variable "subnet" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)

  }))

}

variable "nsg" {
  description = "Map of Network Security Group configurations"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    tags                = optional(map(string))

    security_rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range           = optional(string)
      destination_port_range      = optional(string)
      source_address_prefix       = optional(string)
      destination_address_prefix  = optional(string)
      source_port_ranges          = optional(list(string))
      destination_port_ranges     = optional(list(string))
      source_address_prefixes     = optional(list(string))
      destination_address_prefixes = optional(list(string))
    })))
  }))
}

variable "pip" {
  description = "Map of public IP configurations"
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    allocation_method           = string
    zones                       = optional(list(string))
    sku                         = optional(string)
    idle_timeout_in_minutes     = optional(number)
    ip_tags                     = optional(map(string))
    ddos_protection_mode        = optional(string)
    ddos_protection_plan_id     = optional(string)
    reverse_fqdn                = optional(string)
    domain_name_label           = optional(string)
    public_ip_prefix_id         = optional(string)
    tags                        = optional(map(string))
  }))
}

variable "nic" {
  description = "Map of Network Interface configurations"
  type = map(object({
     # data block variable
    vnet_name         = string
    subnet_name       = string
    pip_name          = string
    # resource block variable
    name                = string
    resource_group_name = string
    location            = string
    ip_forwarding_enabled         = optional(bool)
    accelerated_networking_enabled = optional(bool)
    tags                          = optional(map(string))

    ip_configurations = optional(list(object({
      name                          = string
      # subnet_id                     = string # if we using data block for this then not required here
      private_ip_address_allocation = string
      private_ip_address_version    = optional(string)
      public_ip_address_id          = optional(string)
      primary                       = optional(bool)
    })))
  }))
}

variable "nic_nsg_association" {
  description = "Map defining NIC and NSG association"
  type = map(object({
    # data block variable
    nic_name                = string
    nsg_name                = string
    resource_group_name     = string
  }))
}

variable "key_vault" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku_name            = string

    tenant_id = optional(string)

    enabled_for_deployment          = optional(bool)
    enabled_for_disk_encryption     = optional(bool)
    enabled_for_template_deployment = optional(bool)
    purge_protection_enabled        = optional(bool)
    soft_delete_retention_days      = optional(number)

    access_policies = optional(list(object({
      application_id          = optional(string)
      key_permissions         = optional(list(string))
      secret_permissions      = optional(list(string))
      certificate_permissions = optional(list(string))
      storage_permissions     = optional(list(string))
    })), [])

    tags = optional(map(string))
  }))
}

variable "kv_secrets" {
  type = map(object({
    # Required
    kv_name      = string
    rg_name      = string
    secret_name  = string

    # Optional
    secret_value            = optional(string)
    secret_value_wo         = optional(string)
    secret_value_wo_version = optional(number)

    # Metadata (optional)
    content_type    = optional(string)
    not_before_date = optional(string)
    expiration_date = optional(string)
    tags            = optional(map(string))
  }))
}

# Virtual Machine (Linux)
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