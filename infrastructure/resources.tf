resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_account" "diag_storage" {
  name                        = "vmdiag${replace(var.name, "-", "")}"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  account_tier                = "Standard"
  account_replication_type    = "LRS"

  tags = {
    environment = var.environment
  }
}

module "network" {
  source = "./modules/network"

  name                  = var.name
  address_space         = "10.0.0.0/16"
  subnet_address_space  = "10.0.2.0/24"
  destination           = {
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
  }
  tags = {
    environment = var.environment
  }
}

module "master_node" {
  source = "./modules/vm"

  name = "${var.name}-master"
  auth = {
    username  = var.username
    pubkey    = file(var.pubkey_file)
  }
  size = "Standard_D2s_v3"
  diag_storage_endpoint = azurerm_storage_account.diag_storage.primary_blob_endpoint
  destination = {
    location              = var.location
    resource_group_name   = azurerm_resource_group.rg.name
    nsg_id                = module.network.nsg.id
    subnet_id             = module.network.subnet.id
  }
  tags = {
    environment = var.environment
  }

  provisioning_script = templatefile("./provisioning/install-master.tmpl", {usr = var.username})
}

module "default_rules" {
  source = "./modules/nsg-rules"

  destination = {
    resource_group_name = azurerm_resource_group.rg.name
    nsg_name            = module.network.nsg.name
  }

  rsync_port = var.rsync_port
}

output "master_vm_name" {
  value = module.master_node.vm_name
}

output "master_public_ip" {
  value = module.master_node.public_ip
}

output "master_vm_user" {
  value = module.master_node.vm_user_name
}