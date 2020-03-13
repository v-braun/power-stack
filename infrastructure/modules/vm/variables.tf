variable "name" {
  type = string
  description = "Enter the resource name of the VM"
}

variable "auth" {
  type = object({
    username = string
  })
}

variable "provisioning_script" {
  type = string
}

variable "size" {
  type = string
}

variable "diag_storage_endpoint" {
  type = string
}

variable "destination" {
  type = object({
    location = string
    resource_group_name = string
    subnet_id = string
    nsg_id = string
  })
}

variable "tags" {
  type = map
}
