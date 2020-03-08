variable "destination" {
  type = object({
    resource_group_name = string
    nsg_name            = string
  })
}

variable "rsync_port" {
  type = string
}

resource "azurerm_network_security_rule" "rule_ssh" {
  name                        = "SSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = var.destination.nsg_name
  resource_group_name         = var.destination.resource_group_name
}

resource "azurerm_network_security_rule" "rule_http" {
  name                        = "http"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = var.destination.nsg_name
  resource_group_name         = var.destination.resource_group_name
}

resource "azurerm_network_security_rule" "rule_https" {
  name                        = "https"
  priority                    = 1003
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = var.destination.nsg_name
  resource_group_name         = var.destination.resource_group_name
}

resource "azurerm_network_security_rule" "rule_docker_manage" {
  name                        = "docker-manage"
  priority                    = 1004
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2376"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = var.destination.nsg_name
  resource_group_name         = var.destination.resource_group_name
}

resource "azurerm_network_security_rule" "rule_rsync_backup" {
  name                        = "rsync-backup"
  priority                    = 1005
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = var.rsync_port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = var.destination.nsg_name
  resource_group_name         = var.destination.resource_group_name
}
