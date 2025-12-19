rg = {
  rg1 = {
    name       = "rg-todoapp-project"
    location   = "westus"
    managed_by = " managed by prod team"
    tags = {
      environment = "prod"
      project     = "todo_app_pro"
      owner       = "prod-team"

    }
  }
}

vnet = {
  vnet_front_end = {
    name                = "vnet-todo-app"
    location            = "westus"
    resource_group_name = "rg-todoapp-project"
    address_space       = ["10.0.0.0/16"]
    tags = {
      environment = "prod"
      project     = "todo_app_pro"
      owner       = "prod-team"

    }
  }
}


subnet = {
  subnet_prod = {
    name                 = "subnet_frontend"
    resource_group_name  = "rg-todoapp-project"
    virtual_network_name = "vnet-todo-app"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet_prod2 = {
    name                 = "subnet_backend"
    resource_group_name  = "rg-todoapp-project"
    virtual_network_name = "vnet-todo-app"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

nsg = {
  nsg1 = {
    name                = "nsg-frontend"
    location            = "westus"
    resource_group_name = "rg-todoapp-project"
    tags = {
      environment = "prod"
    }

    security_rules = [
      {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]

  }

  nsg2 = {
    name                = "nsg-backend"
    location            = "westus"
    resource_group_name = "rg-todoapp-project"
    tags = {
      environment = "prod"
    }

    security_rules = [
      {
        name                       = "HTTP"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

pip = {
  pip1 = {
    name                = "pip-frontend"
    location            = "westus"
    resource_group_name = "rg-todoapp-project"
    allocation_method   = "Static"
    tags = {
      environment = "prod"
      project     = "todo_app_pro"
      owner       = "prod-team"

    }
  }

  pip2 = {
    name                    = "pip-backend"
    location                = "westus"
    resource_group_name     = "rg-todoapp-project"
    allocation_method       = "Static"
    sku                     = "Standard"
    idle_timeout_in_minutes = 15
    tags = {
      environment = "prod"
      project     = "todo_app_pro"
      owner       = "prod-team"

    }
  }
}

nic = {
  nic1 = {
    vnet_name                     = "vnet-todo-app"
    subnet_name                   = "subnet_frontend"
    pip_name                      = "pip-frontend"
    name                          = "nic-frontend"
    location                      = "westus"
    resource_group_name           = "rg-todoapp-project"
    enable_ip_forwarding          = false
    enable_accelerated_networking = false
    tags                          = { environment = "prod" }

    ip_configurations = [
      {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        primary                       = true
      }
    ]
  }
  nic2 = {
    vnet_name                     = "vnet-todo-app"
    subnet_name                   = "subnet_backend"
    pip_name                      = "pip-backend"
    name                          = "nic-backend"
    location                      = "westus"
    resource_group_name           = "rg-todoapp-project"
    enable_ip_forwarding          = false
    enable_accelerated_networking = false
    tags                          = { environment = "prod" }

    ip_configurations = [
      {
        name                          = "ipconfig2"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        primary                       = true
      }
    ]
  }
}

nic_nsg_association = {
  asso1 = {
    nic_name            = "nic-frontend"
    nsg_name            = "nsg-frontend"
    resource_group_name = "rg-todoapp-project"
  }
  asso2 = {
    nic_name            = "nic-backend"
    nsg_name            = "nsg-backend"
    resource_group_name = "rg-todoapp-project"
  }
}

key_vault = {
  kv-prod = {
    name                            = "kv-todo-app942"
    resource_group_name             = "rg-todoapp-project"
    location                        = "westus"
    sku_name                        = "standard"
    enabled_for_deployment          = true
    enabled_for_disk_encryption     = true
    enabled_for_template_deployment = false
    purge_protection_enabled        = true
    soft_delete_retention_days      = 7

    access_policies = [
      {
        key_permissions         = ["Get", "List", "Create", "Delete"]
        secret_permissions      = ["Get", "List", "Set", "Delete", "Recover"]
        certificate_permissions = ["Get", "List", "Create"]
        storage_permissions     = ["Get", "List"]
      }
    ]

    tags = {
      environment = "prod"
      owner       = "Zia"
      project     = "todo_app_pro"
    }
  }
}

kv_secrets = {
  secret1 = {
    kv_name      = "kv-todo-app942"
    rg_name      = "rg-todoapp-project"
    secret_name  = "vm-adminusername"
    secret_value = "azureuser"
  }
  secret2 = {
    kv_name      = "kv-todo-app942"
    rg_name      = "rg-todoapp-project"
    secret_name  = "vm-adminpassword"
    secret_value = "Password123!"
  }
  #   secret3 = {
  #   kv_name      = "kv-todo-app"
  #   rg_name      = "rg-todoapp-project"
  #   secret_name  = "vm-adminusername"
  #   secret_value = "azureuser"

  # }
  # secret4 = {
  #   kv_name      = "kv-todo-app"
  #   rg_name      = "rg-todoapp-project"
  #   secret_name  = "vm-adminpassword"
  #   secret_value = "Password123!"
  # }
}

linux_vm = {
  vm1 = {
    name                = "vm-todo-frontend"
    location            = "westus"
    resource_group_name = "rg-todoapp-project"
    size                = "Standard_B1s"

    nic_name = "nic-frontend"
    nic_rg   = "rg-todoapp-project"

    kv_name         = "kv-todo-app942"
    kv_rg           = "rg-todoapp-project"
    username_secret = "vm-adminusername"
    password_secret = "vm-adminpassword"

 
    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 64
    }

    identity_type = "SystemAssigned"

    tags = {
      environment = "prod"
    }
  }

  vm2 = {
    name                = "vm-todo-backend"
    location            = "westus"
    resource_group_name = "rg-todoapp-project"
    size                = "Standard_B1s"

    nic_name = "nic-backend"
    nic_rg   = "rg-todoapp-project"

    kv_name         = "kv-todo-app942"
    kv_rg           = "rg-todoapp-project"
    username_secret = "vm-adminusername"
    password_secret = "vm-adminpassword"

    # zone = "1"

    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 64
    }

    identity_type = "SystemAssigned"

    tags = {
      environment = "prod"
    }
  }
}
