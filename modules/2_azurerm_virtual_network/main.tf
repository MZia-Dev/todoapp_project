resource "azurerm_virtual_network" "vnet" {

  for_each = var.vnet

  # ---------- Required Arguments ---------- #
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space

  # ---------- Optional Arguments ---------- #
  dns_servers             = each.value.dns_servers
  bgp_community           = each.value.bgp_community
  edge_zone               = each.value.edge_zone
  flow_timeout_in_minutes = each.value.flow_timeout_in_minutes
  tags                    = each.value.tags

dynamic "ddos_protection_plan" {
  for_each = lookup(each.value, "ddos_protection_plan", null) == null ? [] : [lookup(each.value, "ddos_protection_plan", null)]

  content {
    id     = ddos_protection_plan.value.id
    enable = ddos_protection_plan.value.enable
  }
}


}