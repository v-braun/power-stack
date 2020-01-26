variable "name" {
    type = string
}

variable "address_space" {
    type = string
}

variable "subnet_address_space" {
    type = string
}

variable "destination" {
  type = object({
    location = string
    resource_group_name = string
  })
}

variable "tags" {
  type = map
}
