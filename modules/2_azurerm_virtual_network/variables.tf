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

