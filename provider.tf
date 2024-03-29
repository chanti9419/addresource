provider "azurerm" {
  version                    = "~> 2.20"
  subscription_id            = var.usr-subscription-id
  tenant_id                  = var.usr-tenant-id
  client_id                  = var.usr-client-id
  client_secret              = var.usr-client-secret
  skip_provider_registration = var.usr-skip-provider-registration
  features {}
}

provider "azurerm" {
  alias                       = "EMF"
  version                     = "~> 2.20"
  subscription_id             = var.usr-subscription-id
  tenant_id                   = var.usr-tenant-id
  client_id                   = var.usr-client-id
  client_secret               = var.usr-client-secret
  skip_provider_registration  = var.usr-skip-provider-registration
  features {}
}

provider "azurerm" {
  alias                      = "image"
  version                    = "~> 2.20"
  subscription_id            = var.usr-os-image-subscription != "" ? var.usr-os-image-subscription : var.usr-subscription-id
  tenant_id                  = var.usr-tenant-id
  client_id                  = var.usr-client-id
  client_secret              = var.usr-client-secret
  skip_provider_registration = var.usr-skip-provider-registration
  features {}
}


provider "azurerm" {
  alias                      = "certificates"
  version                    = "~> 2.20"
  subscription_id            = var.usr-certificates.key-vault-subscription != "" ? var.usr-certificates.key-vault-subscription : var.usr-subscription-id
  tenant_id                  = var.usr-tenant-id
  client_id                  = var.usr-client-id
  client_secret              = var.usr-client-secret
  skip_provider_registration = var.usr-skip-provider-registration
  features {}
}

provider "azurerm" {
  alias                      = "credential"
  version                    = "~> 2.20"
  subscription_id            = var.usr-certificates.key-vault-subscription != "" ? var.usr-certificates.key-vault-subscription : var.usr-subscription-id
  tenant_id                  = var.usr-tenant-id
  client_id                  = var.usr-client-id
  client_secret              = var.usr-client-secret
  skip_provider_registration = var.usr-skip-provider-registration
  features {}

}

provider "azurerm" {
  alias                      = "encryption"
  version                    = "~> 2.20"
  subscription_id            = var.usr-certificates.key-vault-subscription != "" ? var.usr-certificates.key-vault-subscription : var.usr-subscription-id
  tenant_id                  = var.usr-tenant-id
  client_id                  = var.usr-client-id
  client_secret              = var.usr-client-secret
  skip_provider_registration = var.usr-skip-provider-registration
  features {}

}

provider "azurerm" {
  alias                      = "diagnostics"
  version                    = "~> 2.20"
  subscription_id            = var.usr-certificates.key-vault-subscription != "" ? var.usr-certificates.key-vault-subscription : var.usr-subscription-id
  tenant_id                  = var.usr-tenant-id
  client_id                  = var.usr-client-id
  client_secret              = var.usr-client-secret
  skip_provider_registration = var.usr-skip-provider-registration
  features {}

}

provider "azurerm" {
  alias                      = "startup-script"
  version                    = "~> 2.20"
  subscription_id            = var.usr-certificates.key-vault-subscription != "" ? var.usr-certificates.key-vault-subscription : var.usr-subscription-id
  tenant_id                  = var.usr-tenant-id
  client_id                  = var.usr-client-id
  client_secret              = var.usr-client-secret
  skip_provider_registration = var.usr-skip-provider-registration
  features {}

}

provider "azurerm" {
  alias                      = "startup-script-storage"
  version                    = "~> 2.20"
  subscription_id            = var.usr-custom-script-storage-account-key-vault-subscription != "" ? var.usr-custom-script-storage-account-key-vault-subscription : var.usr-subscription-id
  tenant_id                  = var.usr-tenant-id
  client_id                  = var.usr-client-id
  client_secret              = var.usr-client-secret
  skip_provider_registration = var.usr-skip-provider-registration
  features {}
}

# Created alias for  Azure keyvault 
provider "azurerm" {
  alias                      = "emf-keyvault-secret"
  version                    = "~> 2.20"
  subscription_id            = var.usr-custom-script-storage-account-key-vault-subscription != "" ? var.usr-custom-script-storage-account-key-vault-subscription : var.usr-subscription-id-keyvault
  tenant_id                  = var.usr-tenant-id
  client_id                  = var.usr-client-id
  client_secret              = var.usr-client-secret
  skip_provider_registration = var.usr-skip-provider-registration
  features {}
}