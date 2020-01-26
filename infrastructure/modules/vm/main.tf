resource "azurerm_public_ip" "ip" {
    name                         = "${var.name}-ip"
    location                     = var.destination.location
    resource_group_name          = var.destination.resource_group_name
    allocation_method            = "Static"
    tags = var.tags
}

resource "azurerm_network_interface" "ni" {
    name                         = "${var.name}-ni"
    location                     = var.destination.location
    resource_group_name          = var.destination.resource_group_name
    network_security_group_id    = var.destination.nsg_id

    ip_configuration {
        name                          = "${var.name}-ni-config"
        subnet_id                     = var.destination.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.ip.id
    }

    tags = var.tags
}

resource "azurerm_virtual_machine" "vm" {
  name                  = var.name
  location              = var.destination.location
  resource_group_name   = var.destination.resource_group_name
  network_interface_ids = [azurerm_network_interface.ni.id]
  vm_size               = var.size

  storage_os_disk {
      name              = "${var.name}-disc"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
  }

  os_profile {
      computer_name  = var.name
      admin_username = var.auth.username
      custom_data = var.provisioning_script
  }

  os_profile_linux_config {
      disable_password_authentication = true
      ssh_keys {
          path     = "/home/${var.auth.username}/.ssh/authorized_keys"
          key_data = var.auth.pubkey
      }
  }

  boot_diagnostics {
      enabled = "true"
      storage_uri = var.diag_storage_endpoint
  }

  tags = var.tags
}

output "public_ip" {
  value = azurerm_public_ip.ip.ip_address
}

output "vm_name" {
  value = var.name
}

output "vm_user_name" {
  value = ar.auth.username
}
