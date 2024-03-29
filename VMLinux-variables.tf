/*
variable "usr-resource-group-name" {
  type        = string
  description = "The name of the resource group that will be used."
}
*/

variable "usr-location" {
  type        = string
  description = "The Azure region in which the VM and related resources are to be created."
}

################################################################################
# VM core parameters
################################################################################
/*
variable "usr-vm-count" {
  type        = number
  description = "The number of VMs to be created."
}

variable "usr-vm-name" {
  type        = string
  description = "Specified the name of the VM(s)"
}
*/
variable "usr-vm-name-count-suffix" {
  type        = number
  description = "The base count added to the VM name. Example, if VM name is AZETESTW0 and the total number of instances deployed is 3 and suffix is set to 1 , VM names would be AZETESTW01, AZETESTW02, AZETESTW03. If suffix is set to 5 the deployed VM names would be AZETESTW05, AZETESTW06 and AZETESTW07."
  default     = 1
}

variable "usr-vm-size" {
  type        = string
  description = "Specifies the size of the VM(s)."
}

variable "usr-availability-zones-list" {
  type        = list(string) # Note: Azure requires the availability zones to be expressed as a list of strings, not a list of numbers.
  description = "The list of availability zones to be selected from when assigning a VM to a zone."
  default     = ["1", "2", "3"]
}

variable "usr-os-image-name" {
  type        = string
  description = "References an Azure image resource that should be used to create the VM(s). Optional if image publisher, offer, sku, and version are specified."
  default     = ""
}

variable "usr-os-image-gallery-name" {
  type        = string
  description = "The shared image gallery from which to reference the OS image that should be used to create the VM(s). Optional if image publisher, offer, sku, and version are specified."
  default     = ""
}

variable "usr-os-image-resource-group" {
  type        = string
  description = "The resource group that contains the Azure image resource that should be used to create the VM(s). Optional if image publisher, offer, sku, and version are specified."
  default     = ""
}

variable "usr-os-image-subscription" {
  type        = string
  description = "The subscription that contains the Azure image resource that should be used to create the VM(s). Optional if image publisher, offer, sku, and version are specified."
  default     = ""
}

variable "usr-os-image-publisher" {
  type        = string
  description = "Specifies the publisher of the image used to create the VM(s). Not used if image name is specified."
  default     = ""
}

variable "usr-os-image-offer" {
  type        = string
  description = "Specifies the offer of the image used to create the VM(s). Not used if image name is specified."
  default     = ""
}

variable "usr-os-image-sku" {
  type        = string
  description = "Specifies the SKU of the image used to create the VM(s). Not used if image name is specified."
  default     = ""
}

variable "usr-os-image-version" {
  type        = string
  description = "Specifies the version of the image used to create the VM(s). This variable is used when specifying an image from a shared image gallery or a marketplace image."
  default     = ""
}

variable "usr-os-disk-caching" {
  type        = string
  description = "Specifies the caching requirements for the Data Disk. Possible values include None, ReadOnly and ReadWrite"
}

variable "usr-os-disk-size" {
  type        = number
  description = "Specifies the size of OS disk"
  default     = 64
}

variable "usr-os-disk-managed-disk-type" {
  type        = string
  description = "Specifies the type of managed disk to create. Possible values are either Standard_LRS, StandardSSD_LRS, Premium_LRS or UltraSSD_LRS. Defaults to Premium_LRS."
  default     = "Premium_LRS"
}

variable "usr-delete-os-disk-on-termination" {
  type        = bool
  description = "Should the OS Disk be deleted when the VM is destroyed?"
  default     = true
}

variable "usr-delete-data-disks-on-termination" {
  type        = bool
  description = "Should the Data Disks be deleted when the VM is destroyed?"
  default     = true
}

/*
variable "usr-computer-name" {
  type        = string
  description = "Specifies the computer name which has character length only '8'.  For computer name please follow humana standard naming conventions as described in link. [http://architecture.humana.com/azure/AzureIaaSVMNamingStandards/]"
}
*/

variable "usr-admin-username" {
  type        = string
  description = "Specifies the name of the local administrator account for the VM(s)."
}

variable "usr-admin-password" {
  type        = string
  description = "The password associated with the local administrator account for the VM(s)."
}

variable "usr-cloud-init-file-path" {
  type        = string
  description = "The relative file path to a cloud-init file used for initialization of a VM instance on first boot. The maximum binary length of this content is 65535 bytes."
  default     = ""
}

variable "usr-custom-script-local-file-path" {
  type        = string
  description = "The relative file path to a local script file to run on the VM instance using the custom script extension. For Linux this is a script that will be executed by /bin/sh and will be gzip'ed and base64 encoded; the resulting gzip'ed and base64 encoded script must not exceed 256KB."
  default     = ""
}

variable "usr-custom-script-remote-file-uris" {
  type        = list(string)
  description = "An optional list of URIs referenceing files to download for use with the custom script command."
  default     = []
}

variable "usr-custom-script-storage-account-name" {
  type        = string
  description = "The optional name of a storage account from which files may be referenced via the file URIs variable. Only needed if the file URIs are referencing blobs from a storage account."
  default     = ""
}

variable "usr-custom-script-storage-account-key-vault-name" {
  type        = string
  description = "The name of the key vault that stores the access key for the referenced custom script storage account. Only needed if a storage account has been specified."
  default     = ""
}

variable "usr-custom-script-storage-account-key-vault-resource-group" {
  type        = string
  description = "The resource group containing the key vault that stores the access key for the referenced custom script storage account. Only needed if a storage account has been specified."
  default     = ""
}

variable "usr-custom-script-storage-account-key-vault-subscription" {
  type        = string
  description = "The ID of the subscription containing the key vault that stores the access key for the referenced custom script storage account. Only needed if a storage account has been specified."
  default     = ""
}

variable "usr-custom-script-storage-account-key-secret-name" {
  type        = string
  description = "The name of the secret inside of the key vault that holds the access key for the referenced custom script storage account. Only needed if a storage account has been specified."
  default     = ""
}

/*variable "usr-enable-diagnostics" {
  type        = bool
  description = "Specifies whether or not to enable diagnostics for this VM. Set to true to enable diagnostics, or false to not enable."
  default     = false
}*/

variable "usr-enable-monitor-agent" {
  type        = bool
  description = "Specifies whether or not to enable monitor agent for this VM. Set to true to enable monitor agent, or false to not enable."
}

variable "usr-enable-disk-encryption" {
  type        = bool
  description = "Specifies whether or not to enable disk encryption for this VM. Set to true to enable encryption, or false to not enable."
}
/*
variable "usr-diagnostics-storage-account-name" {
  type        = string
  description = "The name of the storage account where diagnostics information from the VM will be logged."
}

variable "usr-diagnostics-storage-account-resource-group-name" {
  type        = string
  description = "The resource group that containst the diagnostics storage account."
}
*/
variable "usr-diagnostics-storage-account-sas-expiry-days" {
  type        = number
  description = "The number of days until the storage account SAS token expires (default 365)."
  default     = 365
}

################################################################################
# VM networking parameters
################################################################################
variable "usr-vnet-name" {
  type        = string
  description = "The name of Virtual network which is attached to the VM"
}

variable "usr-vnet-resource-group-name" {
  type        = string
  description = "The name of the resource group in the virtual network reside"
}

/*
variable "usr-vnet-subnet-name" {
  type        = string
  description = "The name of subnet which is attached to the VM"
}
*/

variable "usr-enable-public-ip-address" {
  type        = bool
  description = "Defines whether a public IP address is assigned to the VMs NIC. Options are true or false."
}

variable "usr-private-ip-address-allocation" {
  type        = string
  description = "Defines how a private IP address is assigned. Options are Static or Dynamic."
}

variable "usr-private-ip-address" {
  type        = string
  description = "The private IP address to statically assign to the VM when there is only a single VM (vm-count = 1)."
  default     = ""
}

variable "usr-private-ip-address-cidr-range" {
  type        = string
  description = "The CIDR range in which to statically assign IP addresses for the VMs when there is more than one VM (vm-count > 1)."
  default     = ""
}

variable "usr-private-ip-address-offset" {
  type        = number
  description = "The number of IP addresses to skip from the private-ip-address-cidr-range when allocating IP addresses for the VMs. Only applicable when there is more than one VM (vm-count > 1)."
  default     = 0
}

variable "usr-nsg-name" {
  type        = string
  description = "The name of the network security group that will be used."
}

variable "usr-enable-nsg-nic-association" {
  type        = bool
  description = "Enable attachment of NSG to NIC"
  default     = true
}

variable "usr-nsg-resource-group-name" {
  type        = string
  description = "The resource group that contains the Azure nsg resource."
  default     = ""
}

################################################################################
# VM data disk parameters
################################################################################
variable "usr-data-disk-size-list" {
  type        = list(number)
  description = "A list that specifies the size of the data disk in gigabytes for the VM(s). The size at index i should match the type at index i in the data disk type list."
}

variable "usr-data-disk-type-list" {
  type        = list(string)
  description = "A list that specifies the type of managed disk to create. Possible values are either Standard_LRS, StandardSSD_LRS, Premium_LRS or UltraSSD_LRS. Defaults to Premium_LRS."
  default     = ["Premium_LRS"]
}

variable "usr-data-disk-caching-list" {
  type        = list(string)
  description = "A list that specifies the caching requirements for the data disk. Possible values include None, ReadOnly and ReadWrite."
}

################################################################################
# VM encryption parameters
################################################################################
/*
variable "usr-key-vault-name" {
  type        = string
  description = "Specifies the name of the Key Vault."
}

variable "usr-key-vault-resource-group-name" {
  type        = string
  description = "The name of the Resource Group in which the Key Vault exists."
}

variable "usr-key-encryption-key-name" {
  type        = string
  description = "The name of the key in the vault which encrypts the key that is used to encrypt the VM disks"
}

*/

variable "usr-key-encryption-algorithm" {
  type        = string
  default     = "RSA-OAEP"
  description = "The name of the key encryption algorithm to use for VM disk encryption"
}

variable "usr-volume-type" {
  type        = string
  description = "Volume Type for encryption. Allowed values are OS, Data, All. Default is All."
  default     = "All"
}



################################################################################
# Log Analytics Workspace Parameters
################################################################################
variable "usr-enable-log-analytics" {
  type        = bool
  description = "Specifies whether log anaytics extension enabled or not."
  default     = false
}

/*
variable "usr-key-vault-law-name" {
  type        = string
  description = "The name of the Key Vault where the Log Analytics workspace ID and Key are stored."
}

variable "usr-key-vault-law-resource-group-name" {
  type        = string
  description = "The resource group of the Key Vault where the Log Analytics workspace ID and Key are stored."
}

variable "usr-lawid" {
  type        = string
  description = "The name of the secret where the value is the Log Analytics Workspace ID"
}

variable "usr-lawkey" {
  type        = string
  description = "The name of the secret where the value is the Log Analytics Workspace Key"
}
*/

################################################################################
# Dynatrace Parameters
################################################################################
variable "usr-dynatrace-tenantid" {
  type        = string
  description = "The Dynatrace TenantId."
}

variable "usr-dynatrace-token" {
  type        = string
  description = "The Dynatrace PaaS token."
}

variable "usr-dynatrace-server-url" {
  type        = string
  description = "The Dynatrace ActiveGate communication endpoint."
}

variable "usr-dynatrace-hostgroup" {
  type        = string
  description = "The Dynatrace HostGroup string. Format: <ApplicationName>-<Tier>-<Environment>"
}

################################################################################
# Certificate Parameters
################################################################################
variable "usr-certificates" {
  type = object({
    key-vault-name           = string
    key-vault-resource-group = string
    key-vault-subscription   = string
    certificates = list(object({
      certificate-name = string
    }))
  })
  description = "The certificates to install on the virtual machine. Specify the name, resource group, and subscription of the key vault containing the certificates to install. The subscription can be left blank if in the same subscription as the virtual machine. The certificates attribute is a list of items for each certificate. The certificate-name attribute corresponds to the certificate name in the key vault. Certificates will be installed into the /var/lib/waagent directory. Each certificate will have a .crt and a .prv file named according to the certificate's thumbprint."
  default = {
    key-vault-name           = ""
    key-vault-resource-group = ""
    key-vault-subscription   = ""
    certificates             = []
  }
}

/*
variable "usr-user-assigned-identity-name" {
  type        = string
  description = "The name of the user assigned managed identity."
}
*/
/*
variable "usr-user-assigned-identity-resource-group" {
  type        = string
  description = "The resource group of the user assigned managed identity."
}
*/
variable "usr-identity-type" {
  type        = string
  description = "Type of identity UserAssigned or SystemAssigned"
}

variable "usr-enable-identity" {
  type        = bool
  description = "Enable/Disable Managed Identity"
}


################################################################################
# Humana Labels 
# Labels and details can be found here: http://architecture.humana.com/cloud-adoption-guide/well-architected-framework/ResourceTagging/
# NOTE:  Only hyphens (-), underscores (_), lowercase characters, and numbers are allowed for keys and values
################################################################################
variable "usr-humana-application-id" {
  type        = string
  description = "ID of the application"
}

variable "usr-billing-ids" {
  type        = string
  description = "Clarity ID"
}

/*
variable "usr-environment-label" {
  type        = string
  description = "Environment of the resource (sbx, dev, test, qa, prod)"
}
*/

variable "usr-privacy-level" {
  type        = string
  description = "List of privacy labels (public, internal, restricted, confidential)"
}

variable "usr-operational-time-end" {
  type        = string
  description = "Date/Time for resources to be be turned off, cron format (5 20 * * 5-6 (8:05 PM on every day-of-week from Friday through Saturday.))"
}

variable "usr-operational-time-start" {
  type        = string
  description = "Date/Time for resources to be be turned on, cron format (5 4 * * 5-6 (4:05 AM on every day-of-week from Friday through Saturday.))"
}

variable "usr-maintenance-time-start" {
  type        = string
  description = "Maintenance start time on the resource, cron format (5 2 * * 5-6 (4:05 AM on every day-of-week from Friday through Saturday.))"
}

variable "usr-maintenance-time-end" {
  type        = string
  description = "Maintenance end time on the resource (hhmm), cron format (5 4 * * 5-6 (4:05 AM on every day-of-week from Friday through Saturday.))"
}

variable "usr-enabled" {
  type        = string
  description = "Set to false to prevent the module from creating any resources"
  default     = "true"
}

/*
variable "usr-tags" {
  type        = map(string)
  description = "Additional tags (e.g. `map(`BusinessUnit`,`XYZ`)"
  default     = {}
}
*/

variable "usr-convert_case" {
  type        = bool
  description = "Convert fields to lower case"
  default     = true
}

#AG Installer Version 
variable "usr-ag-version" {
  type        = string
  description = "dynatrace activegate installer version"
}

variable "usr-oneagent-version" {
  type        = string
  description = "dynatrace oneagent installer version"
}

variable "usr-dynatrace-oneagent-pass-token" {
  type        = string
  description = "The Dynatrace selfMon PaaS token."
}

variable "usr-ag-network-zone" {
  type        = string
  description = "dynatrace activegate network zone (same for both NPE and Prod)"
}


#Dynatrace activegate certificate name
variable "usr-ag-certificate" {
  type        = string
  description = "dynatrace npe activegate certificate name"
}


variable "usr-environment" {
  type        = string
  description = "Environment where it will be deployed to (NPE, Prod)"
}

variable "usr-storage-acct-sas-url" {
  type        = string
  description = "Storage Account SAS URL to be used to download blob"
}


/*
# Secrets stored in Key Vault
variable "usr-key-vault-activegate-admin-password-name" {
  type        = string
  description = "Secret name stored in key vault to retrieve the Admin password for the ActiveGate VMs "
}

variable "usr-key-vault-activegate-certificate-password-name" {
  type        = string
  description = "Secret name stored in key vault to retrieve the certificate password for the ActiveGate VMs "
}

variable "usr-dynatrace-paas-token" {
  type        = string
  description = "Secret name stored in key vault to retrieve the Dynatrace PAAS token for downloading the ActiveGate installer binary"
}
*/

#variable "per_environment_settings" {
#  type = map
#}



/*variable "usr-lb-sku" {
  description = "The SKU of the Azure Load Balancer. Accepted values are Basic and Standard."
}

variable "usr-frontend-ipconfig-name" {
  description = "(Required) Specifies the name of the frontend ip configuration."
  default     = "frontend-config"
}

variable "usr-subnet-vnet-name" {
  description = "The type of storage to use for the managed disk. Allowable values are Standard_LRS, Premium_LRS, StandardSSD_LRS or UltraSSD_LRS."
}

variable "usr-subnet-rg-name" {
  description = "Specifies the name of resource group of the subnet used in load balancer."
}


variable "usr-use-public-ip" {
  description = "Specify true or false. If true, the LB resource will be created through public IP address , if false, the LB resource will be created through private IP address."
  default     = false
}

variable "usr-public-ip-sku" {
  description = "The sku of the public IP address to be assigned to the load balancer."
}

variable "usr-public-ip-allocation-method" {
  description = "Determines whether the public IP address of the load balancer will be statically or dynamically allocated. Static allocation also requires the IP address to be specified. Possible values are Static and Dynamic."
}

variable "usr-public-ip-version" {
  description = "The IP version of the public IP address to be assigned to the load balancer. Possible values are IPv4 or IPv6."
  default     = "IPv4"
}*/

variable "usr-zones" {
  type        = list
  description = "A list of Availability Zones which the Load Balancer's IP Addresses should be created in. Possible values are an empty list or a list of one availability zone."
  default     = []
}

/*variable "usr-lb-rule-protocol" {
  description = "The transport protocol for the external endpoint. Possible values are Tcp, Udp or All."
  default     = "Tcp"
}

variable "usr-lb-frontend-port" {
  description = "The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive."
}

variable "usr-lb-backend-port" {
  description = " The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive."
}

variable "usr-lb-port" {
  description = "Port on which the Probe queries the backend endpoint. Possible values range from 1 to 65535, inclusive."
}

variable "usr-lb-probe-protocol" {
  description = "Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If Tcp is specified, a received ACK is required for the probe to be successful. If Http is specified, a 200 OK response from the specified URI is required for the probe to be successful."
  default     = "Tcp"
}

variable "usr-request-path" {
  description = "The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http. Otherwise, it is not allowed."
  default     = ""
}

variable "usr-lb-interval-in-seconds" {
  description = " The interval, in seconds between probes to the backend endpoint for health status. The default value is 15, the minimum value is 5."
  default     = 30
}

variable "usr-probe-number" {
  description = " The number of failed probe attempts after which the backend endpoint is removed from rotation. The default value is 2. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10.Endpoints are returned to rotation when at least one probe is successful."
  default     = 2
}*/

/*variable "usr-lb-rule-name" {
  type        = list(object({
    name           = string
    probe-name     = string
    protocol       = string
    frontend-port  = number
    backend-port   = number
  }))
  description =  <<EOT
  A list that specifies the Load Balancer Rules.
  1. name           = The name of the LB rule.
  2. protocol       = The transport protocol for the external endpoint. Possible values are Tcp, Udp or All.
  3. frontend-port  = The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive.
  4. backend-port   = The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive.
  5. probe-name     =The name of probe 
  EOT
}*/



/*variable "lb-probe-name" {
  type        = string
  description = "Specifies the name of the Probe."
  default     = "default-probe"
}*/

/*variable "usr-lb-nat-rules" {
  type        = list(object({
    name                = string
    protocol            = string
    frontend-port       = number
    backend-port        = number
  }))
  description = "The NAT rules for the load balancer in front of the virtual machine scale set."
}

variable "usr-lb-nat-pools" {
  type        = list(object({
    name                = string
    frontend-port-start = number
    frontend-port-end   = number
    backend-port        = number
  }))
  description = "The NAT pools for the load balancer in front of the virtual machine scale set. Use for mapping frontend ports to a backend (application) port."
}
*/

variable "usr-vm-nic-names-list" {
  type        = list(string)
  description = " The names of the network interfaces"
  default     = [] 
}

/*variable "usr-nic-name" {
 type        = list
 description = "Specifies the name of the Network Interface Card."
}*/

variable "usr-additional-labels" {
type=map(string)
default={}
description=<<EOF
Any additional labels to be added to the resource. Format: {"label_name1" = "value1","label_name2" = "value2"} 
EOF
}