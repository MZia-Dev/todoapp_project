# -------------------------------
# Resource Group
# -------------------------------
module "rg" {
  source = "../../modules/1_azurerm_resource_group"
  rg     = var.rg
}

# -------------------------------
# Virtual Network
# -------------------------------
module "vnet" {
  source = "../../modules/2_azurerm_virtual_network"
  vnet   = var.vnet

  depends_on = [module.rg]
}

# -------------------------------
# Subnets
# -------------------------------
module "subnet" {
  source = "../../modules/3_azurerm_sub_net"
  subnet = var.subnet

  depends_on = [module.vnet]
}

# -------------------------------
# Network Security Groups
# -------------------------------
module "nsg" {
  source = "../../modules/4_azurerm_network_security_group"
  nsg    = var.nsg

  depends_on = [module.rg]
}

# -------------------------------
# Public IPs
# -------------------------------
module "pip" {
  source = "../../modules/5_azurerm_public_ip"
  pip    = var.pip

  depends_on = [module.rg]
}

# -------------------------------
# Network Interface Cards
# -------------------------------
module "nic" {
  source = "../../modules/6_azurerm_network_interface_card"
  nic    = var.nic

  depends_on = [module.pip,module.subnet,module.rg,module.vnet]
}

# -------------------------------
# NIC → NSG Association
# -------------------------------
module "nic_nsg_association" {
  source              = "../../modules/7_azurerm_nic_nsg_association"
  nic_nsg_association = var.nic_nsg_association

  depends_on = [module.nic,module.nsg]
}

# -------------------------------
# Key Vault
# -------------------------------
module "key_vault" {
  source    = "../../modules/8_azurerm_key_vault"
  key_vault = var.key_vault

  depends_on = [module.rg]
}

# -------------------------------
# Key Vault Secrets
# -------------------------------
module "key_vault_secret" {
  source     = "../../modules/9_azurerm_key_vault_secret"
  kv_secrets = var.kv_secrets

  depends_on = [module.key_vault]
}

# -------------------------------
# Linux Virtual Machines
# -------------------------------
module "linux_vm" {
  source    = "../../modules/10_azurerm_linux_virtual_machine"
  linux_vm  = var.linux_vm

  depends_on = [module.rg,module.key_vault_secret,module.nic_nsg_association]
}