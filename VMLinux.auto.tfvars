#usr-resource-group-name                                     = "dynatrace-monitoring-npe"
usr-location = "eastus2"

################################################################################
# VM core parameters
################################################################################
#usr-vm-count                                                = 3
#usr-vm-name                                                 = "emf-npe-azure10-ag"
usr-vm-name-count-suffix = 1
usr-vm-size              = "Standard_D4s_v3"

usr-availability-zones-list = ["1", "2", "3"]

# These variables are used to specify an OS image from a shared image gallery or an independent image resource.
usr-os-image-name           = "rhel8"
usr-os-image-resource-group = "iaas-images-east2-rg"
usr-os-image-subscription   = "788d0172-c030-4746-b72a-150ffeb686a7"
usr-os-image-gallery-name   = "humana_gallery"

usr-os-image-publisher = ""
usr-os-image-offer     = ""
usr-os-image-sku       = ""
usr-os-image-version   = "latest"

usr-os-disk-caching           = "ReadWrite"
usr-os-disk-managed-disk-type = "Standard_LRS"
usr-os-disk-size              = "100"

usr-delete-os-disk-on-termination    = true
usr-delete-data-disks-on-termination = true

#  For computer name please follow humana standard naming conventions as described in link. [http://architecture.humana.com/azure/AzureIaaSVMNamingStandards/]"

# usr-adm-password value  will come from Azure keyvault, value calling on VMLinux

#usr-computer-name                                           = "emfnpeazure10ag"
usr-admin-username = "Humadmin"
usr-admin-password = ""

# Basic startup script variables: cloud-init-file-path and/or custom-script-local-file-path can be used on their own,
# if the startup script scenario is simple enough to contain within one or both of these files.
usr-cloud-init-file-path          = "example-cloud-init.txt"
usr-custom-script-local-file-path = "startup-script.sh"
# Advanced startup script variables: if the startup script requires more than just the cloud init or custom script referenced
# in the above variables, then utilize the variables below to download additional files, such as installation packages, from
# a hosted location (e.g. a storage account or some other repository). Utilize the custom script or cloud-init file to initiate
# the startup process and utilize these additional files.
# usr-custom-script-remote-file-uris = [
#     "https://fwsnpeterraformstate.blob.core.windows.net/startup-scripts/example-install-package.txt"
# ]
# usr-custom-script-storage-account-name                      = "emfnpestgaccx01"
# usr-custom-script-storage-account-key-vault-name            = "emf-shared-npe-kv"
# usr-custom-script-storage-account-key-vault-resource-group  = "dynatrace-monitoring-npe"
# usr-custom-script-storage-account-key-vault-subscription    = ""
# usr-custom-script-storage-account-key-secret-name           = "storage-act-key"

usr-enable-diagnostics     = false
usr-enable-monitor-agent   = true
usr-enable-disk-encryption = false
usr-enable-log-analytics   = false

#usr-diagnostics-storage-account-name                        = "emfnpestgaccx01"
#usr-diagnostics-storage-account-resource-group-name         = "dynatrace-monitoring-npe"
usr-diagnostics-storage-account-sas-expiry-days = 365


usr-enable-identity = false
usr-identity-type   = "UserAssigned"
#usr-user-assigned-identity-name                             = "emf-terraform-npe"
#usr-user-assigned-identity-resource-group                   = "dynatrace-monitoring-npe"

################################################################################
# VM networking parameters
################################################################################
usr-vnet-name                = "mgmt-workload-east2-vn"
usr-vnet-resource-group-name = "mgmt-east2-rg"
#usr-vnet-subnet-name                                        = "dynatrace-sn"

usr-enable-public-ip-address = false


usr-private-ip-address-allocation = "Dynamic"
usr-private-ip-address            = ""
usr-private-ip-address-cidr-range = ""
usr-private-ip-address-offset     = 0

usr-enable-nsg-nic-association = false
usr-nsg-name                   = "NetworkMonitorVM-nsg"
usr-nsg-resource-group-name    = "mgmt-east2-rg"
################################################################################
# VM data disk parameters
################################################################################
usr-data-disk-size-list    = [100]
usr-data-disk-type-list    = ["Standard_LRS"]
usr-data-disk-caching-list = ["None"]

#usr-data-disk-size-list                                    = [1, 2]
#usr-data-disk-type-list                                    = ["Premium_LRS", "Premium_LRS"]
#usr-data-disk-caching-list                                 = ["ReadWrite", "ReadWrite"]

################################################################################
# VM encryption parameters
################################################################################

#usr-key-vault-name                                          = "emf-shared-npe-kv"
#usr-key-vault-resource-group-name                           = "dynatrace-monitoring-npe"
#usr-key-encryption-key-name                                 = "EMF-VM-Encryption-Key"
usr-key-encryption-algorithm = "RSA-OAEP"
usr-volume-type              = "Data"

################################################################################
# VM Log Analytics Workspace
################################################################################
#usr-key-vault-law-name                                      = "emf-shared-npe-kv"
#usr-key-vault-law-resource-group-name                       = "dynatrace-monitoring-npe"
#usr-lawid                                                   = "efm-law-npe-id"
#usr-lawkey                                                  = "emf-law-npe-key"

################################################################################
# Dynatrace parameters
################################################################################

usr-dynatrace-tenantid   = ""
usr-dynatrace-token      = ""
usr-dynatrace-server-url = ""
usr-dynatrace-hostgroup  = ""

/*
usr-dynatrace-tenantid                                      = "54d139b9-23ee-466d-ad7a-f98e0bd8bdf4"
usr-dynatrace-token                                         = "XEDyCBvRRburiNqsWFbej"
usr-dynatrace-server-url                                    = "https://azureag.np-dt.humana.com:9999/e/54d139b9-23ee-466d-ad7a-f98e0bd8bdf4/api"
usr-dynatrace-hostgroup                                     = "EATestApp-Web-Sec"
*/
# ################################################################################
# # Certificate parameters
# # ################################################################################
# usr-certificates = {
#     key-vault-name                                          = ""
#     key-vault-resource-group                                = ""
#     key-vault-subscription                                  = ""
#     certificates                                            = []
# }

################################################################################
# Humana Labels 
# Labels and details can be found here: http://architecture.humana.com/cloud-adoption-guide/ResourceTagging/
# NOTE:  Only hyphens (-), underscores (_), lowercase characters, and numbers are allowed for keys and values
################################################################################
usr-humana-application-id = "16903"
usr-billing-ids           = "PR00094349"
#usr-environment                                             = "qa"
usr-privacy-level          = "internal"
usr-operational-time-start = "5_6_A_A_5-6"
usr-operational-time-end   = "5_20_A_A_5-6"
usr-maintenance-time-start = "5_2_A_A_5-6"
usr-maintenance-time-end   = "5_4_A_A_5-6"
usr-enabled                = "true"
#usr-tags                                                   = {"asset-id" = "16903", "cagroup" = "Enterprise_Monitoring_And_Feedback","dept" = "12462 - IT HPE - High Performance Engineering","environment" = ""}
#usr-tags                                                    = {"testtag1" = "testtag1", "testtag2" = "testtag2", "environment" = "qa"  }
#usr-tags                                                    = {"environment" = "qa"}
#usr-convert_case                                           = true

#Dynatrace Activegate installer version, default value is latest.
#For latest activegate version to install use : latest as a value for any specific version use value , eg: 1.197.115.20200714-141320
usr-ag-version              = "latest"
usr-oneagent-version        = "latest"

# Network zone for ActiveGate (same for both NPE and Prod)
usr-ag-network-zone         = "azure.eastus2.az1.internal.oa"

#Dynatrace Certificate Name:

usr-ag-certificate = "azureaggreenfield.np-dt.humana.com.pfx"