resource "azurerm_virtual_network" "network" {
    name                = "${var.name}-vnet"
    address_space       = [var.address_space]
    location            = var.destination.location
    resource_group_name = var.destination.resource_group_name
    tags = var.tags
}

resource "azurerm_subnet" "subnet" {
    name                 = "${var.name}-subnet"
    resource_group_name  = var.destination.resource_group_name
    virtual_network_name = azurerm_virtual_network.network.name
    address_prefix       = var.subnet_address_space
}

resource "azurerm_network_security_group" "nsg" {
    name                = "${var.name}-nsg"
    location            = var.destination.location
    resource_group_name = var.destination.resource_group_name
    tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

output "subnet" {
  value = azurerm_subnet.subnet
}

output "nsg" {
  value = azurerm_network_security_group.nsg
}