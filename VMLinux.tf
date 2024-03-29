#----------main.tf -------
/*
locals {
  usr-resource-group-name   = usr-environment == "npe" ? "dynatrace-monitoring-npe" : "dynatrace-monitoring-prd"
}
*/

locals {
  per_environment_settings = tomap({
    npe = {
      usr-resource-group-name                             = "dynatrace-monitoring-npe",
      usr-vm-count                                         = 3,
      usr-vm-name                                         = "emf-npe-azure10-east-ag",
      usr-computer-name                                   = "emfnpeazure10ag",
      usr-diagnostics-storage-account-name                = "emfnpestgaccx01",
      usr-diagnostics-storage-account-resource-group-name = "dynatrace-monitoring-npe",
      usr-user-assigned-identity-name                     = "emf-terraform-npe",
      usr-user-assigned-identity-resource-group           = "dynatrace-monitoring-npe",
      usr-vnet-subnet-name                                = "dynatrace-sn",
      usr-key-vault-name                                  = "emf-npe-east2-kv",
      usr-key-vault-resource-group-name                   = "fws-hpe-npe-east2-emf-rg",
      usr-key-encryption-key-name                         = "EMF-DTVM-Encryption-Key",
      usr-key-vault-law-name                              = "",
      usr-lawid                                           = "",
      usr-lawkey                                          = "",
      usr-key-vault-law-resource-group-name               = "",
      usr-environment-label                               = "qa",
      usr-tags                                            = { "environment" = "qa" },
      usr-ag-certificate-name                             = "azureaggreenfield.np-dt.humana.com.pfx",
      usr-ag-certificate-alias                            = "azureaggreenfield.np-dt.humana.com",
      usr-key-vault-activegate-admin-password-name        = "az1dotzero-ag-npe-admin-password",
      usr-lb-name                          = "emf-azure10-activategate-npe-ilb",
      usr-lb-bcp-name                      = "emf-azure10-activategate-npe-lb-bepool",
      usr-dynatrace-oneagent-apiurl                       = "https://ewf60619.live.dynatrace.com/api",
      usr-key-vault-activegate-certificate-password-name  = "az1dotzero-ag-npe-certificate-password",
      usr-dynatrace-paas-token                            = "az1dotzero-ag-npe-paas-token"
      usr-dynatrace-oneagent-pass-token               = "dynatrace-selfmon-pas-token"
      usr-vm-nic-names-list                               = ["emf-npe-azure10-east-ag-nic-1", "emf-npe-azure10-east-ag-nic-2", "emf-npe-azure10-east-ag-nic-3"]
      usr-dynatrace-apiurl                                = "https://cagf.np-dt.humana.com/e/54d139b9-23ee-466d-ad7a-f98e0bd8bdf4/api"
      usr-dynatrace-lbname                                = "https://np-dt.humana.com:443/communication"                                    #Added loadbalancer variable specific to NPE vs Prod. @Avinash.P
      usr-dynatrace-DNSentrypoint-url                     = "https://azureaggreenfield.np-dt.humana.com:9999"                             #Added DNS Entry URL variable specific to NPE vs Prod. @Avinash.P
     }
    prod = {
      usr-resource-group-name                             = "dynatrace-monitoring-prd"
      usr-vm-count                                        = 3,
      usr-vm-name                                         = "emf-prod-azure10-ag",
      usr-computer-name                                   = "emfprodazure10ag",
      usr-diagnostics-storage-account-name                = "emfprodstgaccx01",
      usr-diagnostics-storage-account-resource-group-name = "dynatrace-monitoring-prod",
      usr-user-assigned-identity-name                     = "emf-terraform-prod",
      usr-user-assigned-identity-resource-group           = "dynatrace-monitoring-prod",
      usr-vnet-subnet-name                                = "dynatrace-prod-sn",
      usr-key-vault-name                                  = "fws-hpe-prd-east2-emf-kv",
      usr-key-vault-resource-group-name                   = "fws-hpe-prd-east2-emf-rg",
      usr-key-encryption-key-name                         = "EMF-azonedotzero-AG-prod-encryption-key",
      usr-key-vault-law-name                              = "",
      usr-lawid                                           = "",
      usr-lawkey                                          = "",
      usr-key-vault-law-resource-group-name               = "",
      usr-environment-label                               = "prod",
      usr-tags                                            = { "environment" = "prod" },
      usr-ag-certificate-name                             = "azureagonedotzero-dt.humana.com.pfx",
      usr-ag-certificate-alias                            = "azureagonedotzero-dt.humana.com",
      usr-key-vault-activegate-admin-password-name        = "az1dotzero-ag-prod-admin-password",
      usr-lb-name                          = "emf-azure10-activategate-prod-ilb",
      usr-lb-bcp-name                      = "emf-azure10-activategate-prod-lb-bepool",
      usr-dynatrace-oneagent-apiurl                       = "https://ewf60619.live.dynatrace.com/api",
      usr-key-vault-activegate-certificate-password-name  = "az1dotzero-ag-prod-certificate-password",
      usr-dynatrace-paas-token                            = "az1dotzero-ag-prod-paas-token"
      usr-dynatrace-oneagent-pass-token               = "dynatrace-selfmon-pas-token"
      usr-vm-nic-names-list                               = ["emf-prod-azure10-ag-nic-1", "emf-prod-azure10-ag-nic-2", "emf-prod-azure10-ag-nic-3"]
      usr-dynatrace-apiurl                                = "https://dt.humana.com/e/d3610855-748f-4365-9bb1-f036451fac27/api"
      usr-dynatrace-lbname                                = "https://dt.humana.com:443/communication"       #Added loadbalancer variable specific to NPE vs Prod. @Avinash.P
      usr-dynatrace-DNSentrypoint-url                     = "https://azureagonedotzero-dt.humana.com:9999"  #Added DNS Entry URL variable specific to PROD for recycling 04/03/2023. @Avinash.P
    }
  })
 
  usr-resource-group-name                             = lookup(local.per_environment_settings[var.usr-environment],"usr-resource-group-name","")
  usr-vm-count                                        = lookup(local.per_environment_settings[var.usr-environment],"usr-vm-count",0)
  usr-vm-name                                         = lookup(local.per_environment_settings[var.usr-environment],"usr-vm-name","")
  usr-computer-name                                   = lookup(local.per_environment_settings[var.usr-environment],"usr-computer-name","")
  usr-diagnostics-storage-account-name                = lookup(local.per_environment_settings[var.usr-environment],"usr-diagnostics-storage-account-name","")
  usr-diagnostics-storage-account-resource-group-name = lookup(local.per_environment_settings[var.usr-environment],"usr-diagnostics-storage-account-resource-group-name","")
  usr-user-assigned-identity-name                     = lookup(local.per_environment_settings[var.usr-environment],"usr-user-assigned-identity-name","")
  usr-user-assigned-identity-resource-group           = lookup(local.per_environment_settings[var.usr-environment],"usr-user-assigned-identity-resource-group","")
  usr-vnet-subnet-name                                = lookup(local.per_environment_settings[var.usr-environment],"usr-vnet-subnet-name","")
  usr-key-vault-name                                  = lookup(local.per_environment_settings[var.usr-environment],"usr-key-vault-name","")
  usr-key-vault-resource-group-name                   = lookup(local.per_environment_settings[var.usr-environment],"usr-key-vault-resource-group-name","")
  usr-key-encryption-key-name                         = lookup(local.per_environment_settings[var.usr-environment],"usr-key-encryption-key-name","")
  usr-key-vault-law-name                              = lookup(local.per_environment_settings[var.usr-environment],"usr-key-vault-law-name","")
  usr-lawid                                           = lookup(local.per_environment_settings[var.usr-environment],"usr-lawid","")
  usr-lawkey                                          = lookup(local.per_environment_settings[var.usr-environment],"usr-lawkey","")
  usr-key-vault-law-resource-group-name               = lookup(local.per_environment_settings[var.usr-environment],"usr-key-vault-law-resource-group-name","")
  usr-environment-label                               = lookup(local.per_environment_settings[var.usr-environment],"usr-environment-label","")
  usr-tags                                            = lookup(local.per_environment_settings[var.usr-environment],"usr-tags","")
  usr-ag-certificate-name                             = lookup(local.per_environment_settings[var.usr-environment],"usr-ag-certificate-name","")
  usr-ag-certificate-alias                            = lookup(local.per_environment_settings[var.usr-environment],"usr-ag-certificate-alias","")
  usr-key-vault-activegate-admin-password-name        = lookup(local.per_environment_settings[var.usr-environment],"usr-key-vault-activegate-admin-password-name","")
  usr-key-vault-activegate-certificate-password-name  = lookup(local.per_environment_settings[var.usr-environment],"usr-key-vault-activegate-certificate-password-name","")
  usr-dynatrace-paas-token                            = lookup(local.per_environment_settings[var.usr-environment],"usr-dynatrace-paas-token","")
  usr-dynatrace-apiurl                                = lookup(local.per_environment_settings[var.usr-environment],"usr-dynatrace-apiurl","")
  usr-dynatrace-oneagent-apiurl                       = lookup(local.per_environment_settings[var.usr-environment],"usr-dynatrace-oneagent-apiurl","")
  usr-lb-name                                         = lookup(local.per_environment_settings[var.usr-environment],"usr-lb-name","")
  usr-subnet-name                                     = lookup(local.per_environment_settings[var.usr-environment],"usr-subnet-name","")
  usr-private-ip-address                   = lookup(local.per_environment_settings[var.usr-environment],"usr-private-ip-address","")
  usr-lb-bcp-name                          = lookup(local.per_environment_settings[var.usr-environment],"usr-lb-bcp-name","")
  usr-lb-rule-name                         = lookup(local.per_environment_settings[var.usr-environment],"usr-lb-rule-name","")
  usr-lb-probe-name                        = lookup(local.per_environment_settings[var.usr-environment],"usr-lb-probe-name","")
  usr-vm-nic-names-list                    = lookup(local.per_environment_settings[var.usr-environment],"usr-vm-nic-names-list","")
  usr-dynatrace-oneagent-pass-token        = lookup(local.per_environment_settings[var.usr-environment],"usr-dynatrace-oneagent-pass-token","")
  usr-dynatrace-lbname                     = lookup(local.per_environment_settings[var.usr-environment],"usr-dynatrace-lbname","")
  usr-dynatrace-DNSentrypoint-url          = lookup(local.per_environment_settings[var.usr-environment],"usr-dynatrace-DNSentrypoint-url","")
}

# Get Azure Key Vault details that stores secrets
data "azurerm_key_vault" "dynatraceagkv" {
  provider            = "azurerm.emf-keyvault-secret"
  name                = local.usr-key-vault-name
  resource_group_name = local.usr-key-vault-resource-group-name
}

# Retrieve VM Admin Password from Key vault
data "azurerm_key_vault_secret" "dynagnpeadminsecret" {
  provider     = "azurerm.emf-keyvault-secret"
  name         = local.usr-key-vault-activegate-admin-password-name
  key_vault_id = data.azurerm_key_vault.dynatraceagkv.id
  #depends_on   = azurerm_key_vault.dynagnpekv
}

# Retrieve ActiveGate Cert Password from Key vault
data "azurerm_key_vault_secret" "dynagnpecertpass" {
  provider     = "azurerm.emf-keyvault-secret"
  name         = local.usr-key-vault-activegate-certificate-password-name
  key_vault_id = data.azurerm_key_vault.dynatraceagkv.id
  #depends_on   = azurerm_key_vault.dynagnpekv
}

# Retrieve PaaS token for downloading the installer
data "azurerm_key_vault_secret" "dynagnpetoken" {
  provider   = "azurerm.emf-keyvault-secret"
  name     = local.usr-dynatrace-paas-token
  #key_vault_id        = data.azurerm_key_vault.dynagnpekvtoken.id
  key_vault_id = data.azurerm_key_vault.dynatraceagkv.id
  #depends_on   = azurerm_key_vault.dynagnpekv
}



data "azurerm_key_vault_certificate" "dynatraceagcustomhumanacert"  {
  provider   = "azurerm.emf-keyvault-secret"
  name     = "azureagonedotzero-NPEAGCert"
  key_vault_id = data.azurerm_key_vault.dynatraceagkv.id
  }


data "template_file" "cloud-init" {
  count    = var.usr-cloud-init-file-path != "" ? 1 : 0
  template = file("${path.module}/${var.usr-cloud-init-file-path}")
  vars = {
    humana-application-id = var.usr-humana-application-id
  }
}

data "template_file" "custom-script" {
  count    = var.usr-custom-script-local-file-path != "" ? 1 : 0
  template = file("${path.module}/${var.usr-custom-script-local-file-path}")
  vars = {
    humana-application-id     = var.usr-humana-application-id
    dynatrace_ag_version      = var.usr-ag-version
    dynatrace_oneagent_version      = var.usr-oneagent-version
    dynatrace_apiurl          = local.usr-dynatrace-apiurl
    dynatrace_oneagent_apiurl = local.usr-dynatrace-oneagent-apiurl
    dynatrace_ag_cert_name    = local.usr-ag-certificate-name
    dynatrace_ag_cert_alias   = local.usr-ag-certificate-alias
    /*dynatrace_ag_cert_rawdata = data.azurerm_key_vault_certificate.dynatraceagcustomhumanacert.certificate_data*/
    storage_acct_sas_url      = var.usr-storage-acct-sas-url
    dynatrace_ag_network_zone = var.usr-ag-network-zone 
    dynatrace_ag_cert_pass    = data.azurerm_key_vault_secret.dynagnpecertpass.value
    dynatrace_ag_paas_token   = data.azurerm_key_vault_secret.dynagnpetoken.value
    dynatrace_og_pass_token   = var.usr-dynatrace-oneagent-pass-token
    dynatrace_loadbalancerUrl = local.usr-dynatrace-lbname
    dynatrace_DNSentrypointUrl = local.usr-dynatrace-DNSentrypoint-url
   }
}

data "azurerm_key_vault" "startup-script-storage" {
  provider            = "azurerm.startup-script-storage"
  count               = var.usr-custom-script-storage-account-key-vault-name != "" ? 1 : 0
  name                = var.usr-custom-script-storage-account-key-vault-name
  resource_group_name = var.usr-custom-script-storage-account-key-vault-resource-group
}

data "azurerm_key_vault_secret" "startup-script-storage-key" {
  provider     = "azurerm.startup-script-storage"
  count        = var.usr-custom-script-storage-account-key-secret-name != "" ? 1 : 0
  name         = var.usr-custom-script-storage-account-key-secret-name
  key_vault_id = data.azurerm_key_vault.startup-script-storage[0].id
}




# Create Linux Virtual Machine
module "virtual-machine-linux" {
  #source  = "automation.humana.com/humana_tfe/eca-linuxvm/azurerm"
source  = "app.terraform.io/humanaprd/eca-linuxvm/azurerm"
version = "13.0.9"
  providers = {
    azurerm.image          = azurerm.image
    azurerm.certificates   = azurerm.certificates
    azurerm.startup-script = azurerm.startup-script
    azurerm.diagnostics    = azurerm.diagnostics
    azurerm.encryption     = azurerm.encryption
    azurerm.credential     = azurerm.credential
  }
  ################################################################################
  # Subscription parameters
  ################################################################################
  client-id           = var.usr-client-id
  subscription-id     = var.usr-subscription-id
  tenant-id           = var.usr-tenant-id
  client-secret       = var.usr-client-secret
  #resource-group-name = var.usr-resource-group-name
  resource-group-name = local.usr-resource-group-name
  location            = var.usr-location
  tags                = local.usr-tags

  ################################################################################
  # VM core parameters
  ################################################################################
  #vm-count                         = var.usr-vm-count
  vm-count                         = local.usr-vm-count
  #vm-name                          = var.usr-vm-name
  vm-name                          = local.usr-vm-name
  vm-name-count-suffix             = var.usr-vm-name-count-suffix
  vm-size                          = var.usr-vm-size
  availability-zones-list          = var.usr-availability-zones-list
  os-image-name                    = var.usr-os-image-name
  os-image-gallery-name            = var.usr-os-image-gallery-name
  os-image-resource-group          = var.usr-os-image-resource-group
  os-image-subscription            = var.usr-os-image-subscription
  os-image-publisher               = var.usr-os-image-publisher
  os-image-offer                   = var.usr-os-image-offer
  os-image-sku                     = var.usr-os-image-sku
  os-image-version                 = var.usr-os-image-version
  os-disk-caching                  = var.usr-os-disk-caching
  enable-disk-encryption           = var.usr-enable-disk-encryption
  os-disk-size                     = var.usr-os-disk-size
  os-disk-managed-disk-type        = var.usr-os-disk-managed-disk-type
  delete-os-disk-on-termination    = var.usr-delete-os-disk-on-termination
  delete-data-disks-on-termination = var.usr-delete-data-disks-on-termination

  # For computer name please follow humana standard naming conventions as described in link. [http://architecture.humana.com/azure/AzureIaaSVMNamingStandards/]"

  #computer-name  = var.usr-computer-name
  computer-name  = local.usr-computer-name
  admin-username = var.usr-admin-username
  #admin-password                                  = var.usr-admin-password
  admin-password = data.azurerm_key_vault_secret.dynagnpeadminsecret.value // Toget actual value

  cloud-init                                      = length(data.template_file.cloud-init) > 0 ? data.template_file.cloud-init[0].rendered : ""
  custom-script                                   = length(data.template_file.custom-script) > 0 ? data.template_file.custom-script[0].rendered : ""
  custom-script-file-uris                         = var.usr-custom-script-remote-file-uris
  custom-script-storage-account-name              = var.usr-custom-script-storage-account-name
  custom-script-storage-account-key               = var.usr-custom-script-storage-account-key-secret-name != "" ? data.azurerm_key_vault_secret.startup-script-storage-key[0].value : ""
  enable-monitor-agent                            = var.usr-enable-monitor-agent
  /*enable-diagnostics                              = var.usr-enable-diagnostics*/
  diagnostics-storage-account-name                = local.usr-diagnostics-storage-account-name
  diagnostics-storage-account-resource-group-name = local.usr-diagnostics-storage-account-resource-group-name
  diagnostics-storage-account-sas-expiry-days     = var.usr-diagnostics-storage-account-sas-expiry-days

  enable-identity                       = var.usr-enable-identity
  identity-type                         = var.usr-identity-type
  user-assigned-identity-name           = local.usr-user-assigned-identity-name
  user-assigned-identity-resource-group = local.usr-user-assigned-identity-resource-group

  ################################################################################
  # VM networking parameters
  ################################################################################
  vnet-name                = var.usr-vnet-name
  vnet-resource-group-name = var.usr-vnet-resource-group-name
  vnet-subnet-name         = local.usr-vnet-subnet-name
  #enable-public-ip-address      = var.usr-enable-public-ip-address
  private-ip-address-allocation = var.usr-private-ip-address-allocation
  private-ip-address            = var.usr-private-ip-address
  private-ip-address-cidr-range = var.usr-private-ip-address-cidr-range
  private-ip-address-offset     = var.usr-private-ip-address-offset

  enable-nsg-nic-association = var.usr-enable-nsg-nic-association
  nsg-name                   = var.usr-nsg-name
  nsg-resource-group-name    = var.usr-nsg-resource-group-name

  ################################################################################
  # VM data disk parameters
  ################################################################################
  data-disk-caching-list = var.usr-data-disk-caching-list
  data-disk-size-list    = var.usr-data-disk-size-list
  data-disk-type-list    = var.usr-data-disk-type-list

  ################################################################################
  # VM encryption parameters
  ################################################################################
  key-vault-name                = local.usr-key-vault-name
  key-vault-resource-group-name = local.usr-key-vault-resource-group-name
  key-encryption-key-name       = local.usr-key-encryption-key-name
  key-encryption-algorithm      = var.usr-key-encryption-algorithm
  volume-type                   = var.usr-volume-type
  ################################################################################
  # VM Log Analytics Workspace
  ################################################################################
  key-vault-law-name                = local.usr-key-vault-law-name
  key-vault-law-resource-group-name = local.usr-key-vault-law-resource-group-name
  lawid                             = local.usr-lawid
  lawkey                            = local.usr-lawkey
  enable-log-analytics              = var.usr-enable-log-analytics
  ################################################################################
  # Dynatrace OneAgent parameters
  ################################################################################
  dynatrace-tenantid   = var.usr-dynatrace-tenantid
  dynatrace-token      = var.usr-dynatrace-token
  dynatrace-server-url = var.usr-dynatrace-server-url
  dynatrace-hostgroup  = var.usr-dynatrace-hostgroup

  ################################################################################
  # Certificate Parameters
  ################################################################################
  certificates = var.usr-certificates
}


data "azurerm_network_interface" "dynactivegate_nics" {
    provider                  = azurerm.EMF
    depends_on                = [module.virtual-machine-linux]
    count                     = length(local.usr-vm-nic-names-list) > 0 ? length(local.usr-vm-nic-names-list) : 0
    name                      = local.usr-vm-nic-names-list[count.index]
    resource_group_name       = local.usr-resource-group-name
}

output "network_interface_id" {
  value = data.azurerm_network_interface.dynactivegate_nics.*.id
}

data "azurerm_lb" "dynactivegatelb" {
  provider                  = azurerm.EMF
  depends_on                = [module.virtual-machine-linux]
  name                      = local.usr-lb-name
  resource_group_name       = local.usr-resource-group-name
}

data "azurerm_lb_backend_address_pool" "dynactivegatelbbackendpool" {
  provider                  = azurerm.EMF
  depends_on                = [module.virtual-machine-linux]
  name                      = local.usr-lb-bcp-name
  loadbalancer_id           = data.azurerm_lb.dynactivegatelb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "dynagnodevmbepool" {
  provider                  = azurerm.EMF
  depends_on                = [module.virtual-machine-linux]
  count                     = length(local.usr-vm-nic-names-list) > 0 ? length(local.usr-vm-nic-names-list) : 0
 
  #network_interface_id    = "${element("${data.azurerm_network_interface.dynactivegate_nics.*.id}",count.index)}"
  #ip_configuration_name    = "${element("${data.azurerm_network_interface.dynactivegate_nics.*.ip_configuration[0]}",count.index).name}"
  
  network_interface_id    = element(data.azurerm_network_interface.dynactivegate_nics.*.id,count.index)
  ip_configuration_name   = element(data.azurerm_network_interface.dynactivegate_nics.*.ip_configuration[0],count.index).name
  
 # backend_address_pool_id  = "${data.azurerm_lb_backend_address_pool.dynactivegatelbbackendpool.id}"
  backend_address_pool_id  = data.azurerm_lb_backend_address_pool.dynactivegatelbbackendpool.id
 }



################################################################################
# Humana Labels 
# Labels and details can be found here: http://architecture.humana.com/cloud-adoption-guide/well-architected-framework/ResourceTagging/
# NOTE:  Only hyphens (-), underscores (-), lowercase characters, and numbers are allowed for keys and values    
################################################################################
module "azure-labels" {
  #source  = "automation.humana.com/humana_tfe/eca-labels/azurerm"
  source  = "app.terraform.io/humanaprd/eca-labels/azurerm"
  version = "13.0.2"
  #source = "git::https://humana:#{System.AccessToken}#@dev.azure.com/humana/Architecture/_git/Ref.Cloud.Azure.Golden.Labels?ref=3.0.0-BETA"
  #source = "git::https://humana@dev.azure.com/humana/Architecture/_git/Ref.Cloud.Azure.Golden.Labels?ref=3.0.0-BETA"

  /*humana-application-id  = var.usr-humana-application-id
  billing-ids            = var.usr-billing-ids
  environment            = local.usr-environment-label
  privacy-level          = var.usr-privacy-level*/
  operational-time-start = var.usr-operational-time-start
  operational-time-end   = var.usr-operational-time-end
  maintenance-time-start = var.usr-maintenance-time-start
  maintenance-time-end   = var.usr-maintenance-time-end
  enabled                = var.usr-enabled
  tags                   = local.usr-tags
  convert_case           = var.usr-convert_case
}