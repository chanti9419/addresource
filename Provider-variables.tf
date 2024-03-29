variable "usr-subscription-id" {
  description = "The subscription_id of a service principal in the owner role for the subscription"
}

variable "usr-tenant-id" {
  description = "The tenant_id of a service principal in the owner role for the subscription"
}

variable "usr-client-id" {
  description = "The client_id of a service principal in the owner role for the subscription"
}

variable "usr-client-secret" {
  description = "The secret key (password) of a service principal in the owner role for the subscription. variable needs to be pulled from Azure Devops Key Vault and passed in at build time. DO NOT INCLUDE IN AND FILES!!"
}

variable "usr-skip-provider-registration" {
  description = "(Optional) Should the AzureRM Provider skip registering the Resource Providers it supports? This can also be sourced from the ARM_SKIP_PROVIDER_REGISTRATION Environment Variable. Defaults to false."
  default     = true
}

variable "usr-subscription-id-keyvault" {
  description = "The subscription_id of a keyvault  in the owner role for the subscription"
}