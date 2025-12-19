variable "nic_nsg_association" {
  description = "Map defining NIC and NSG association"
  type = map(object({
    # data block variable
    nic_name                = string
    nsg_name                = string
    resource_group_name     = string
  }))
}