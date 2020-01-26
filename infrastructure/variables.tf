variable "subscription_id" {
  type = string
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "client_id" {
  type = string
  description = "Enter Client ID for Application created in Azure AD"
}

variable "client_secret" {
  type = string
  description = "Enter Client secret for Application in Azure AD"
}

variable "tenant_id" {
  type = string
  description = "Enter Tenant ID / Directory ID of your Azure AD. Run Get-AzureSubscription to know your Tenant ID"
}

variable "location" {
  type = string
  description = "The default Azure region for the resource provisioning"
  default = "WestEurope"
}

variable "name" {
  type = string
  description = "Base name of the entire stack"
}

variable "username" {
  type = string
  description = "Enter admin username to SSH into Linux VM"
}

variable "pubkey_file" {
  type = string
  description = "Enter the public key to use for ssh connections"
  default = "~/.ssh/id_rsa.pub"
}

variable "environment" {
  type = string
  description = "Enter the ENV, it will be assigned as a TAG to all the resources"
}