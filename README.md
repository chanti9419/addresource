# Introduction 
This is an example Terraform repository to demonstrate how to create an Azure Linux VM. Full documentation on how to use this can be found on the [Architecture Knowledge Center](http://architecture.humana.com/azure/AzureVirtualMachines/) site as well as Microsoft's [Virtual Machines Documentation](https://docs.microsoft.com/en-us/azure/virtual-machines/).

# Getting Started
This repo includes an example you will need to fork this to create your own repo, following the instructions [here] (http://architecture.humana.com/azure/AzureVirtualMachines/)

# Quick Start
A Quick start guide is available [here] (http://architecture.humana.com/building-blocks/vmlinux/)

# Build and Test
Create build and release pipelines to handle execution of your Terraform code. Please refer to [the document](http://architecture.humana.com/azure/AzureVirtualMachines/) for further details.

# Contribute
This repo is an example only and so it is in a read only state.  To correct issues or suggest changes, send an e-mail to Innovate@humana.com

# Releases
# Releases
- PROD GLAPI recycle run for 04/03/2023
## 3.0.16-BETA
 - provider 2.0 upgrade
 - skip provider registration flag added
 
## 3.0.15-BETA
 - VM name logic fix
 - The base count parameter vm-name-count-suffix added for the VM/Host name. Example, if VM/Host name is AZETESTW0 and the total number of instances deployed is 3 and suffix is set to 1 , VM/Host names would be AZETESTW01, AZETESTW02, AZETESTW03. If suffix is set to 5 the deployed VM/Host names would be AZETESTW05, AZETESTW06 and AZETESTW07."
  -------------------------------------------------------------
## 3.0.13-BETA
 - Enabled use of Managed Identities in the Virtual Machine
-------------------------------------------------------------
## 3.0.12-BETA
 - Disk Encryption is made optional
 - Tag issue fix for clear data subscription
 - Log Analytics agent is made optional
-------------------------------------------------------------
## 3.0.11-BETA
- Install Security Agents FireEye and MacFee. Minimum version of image required:
    - humana_gallery/win2019 - 1.3.5
    - humana_gallery/win2016 - 1.5.8
    - humana_gallery/rhel77 - 1.1.8
    - humana_gallery/oracle77 - 1.1.9
-------------------------------------------------------------
## 3.0.10-BETA
- Diagnostic extension issue fix.
-------------------------------------------------------------
## 3.0.9-BETA
- NSG association to NIC capability added.
-------------------------------------------------------------
## 3.0.8-BETA
- Added OS disk size parameter and output file for network interface.
-------------------------------------------------------------
## 3.0.7-BETA
- Enabled selecting specific image versions from a shared image gallery via the os-image-version variable.
-------------------------------------------------------------
## 3.0.6-BETA
- Added certificates variable to enable installation of certificates onto the virtual machine. Certificates are installed into the /var/lib/waagent directory on the virtual machine. Each certificate gets a .crt and .prv file with filename based on the certificate thumbprint.
-------------------------------------------------------------
## 3.0.5-BETA
- Added enable-monitor-agent variable to specify whether the monitor agent extension will be installed (default = true).
-------------------------------------------------------------
## 3.0.4-BETA
- Added private-ip-address variable to simplify static IP address assignment for single VMs.
-------------------------------------------------------------
## 3.0.3-BETA
- Enabled the LinuxDiagnostic extension. This will be installed with initial settings to enable guest-level diagnostics using the designated diagnostics storage account.
- Added logic to merge resource group tags with the tags variable in order to avoid terraform generating a plan that includes modification of resources to remove tags that are automatically applied from the resource group.
-------------------------------------------------------------
## 3.0.2-BETA
- Added support for Dynatrace VM Extension.
-------------------------------------------------------------
## 3.0.1-BETA
- Revised backup functionality to align with Recovery Services Vault module. Replaced variable that allowed directly picking the backup policy and replaced with functionality to determine backup policy based on the environment tag.
- Fixed issue where data disk would be destroyed and recreated on a subsequent execution of the module.
-------------------------------------------------------------
## 3.0.0-BETA
* 3.0.0-BETA - Updated humana.visualstudio.com to dev.azure.com/humana/
-------------------------------------------------------------
## 2.0.10-BETA
- Added support for referencing an OS image from a shared image gallery.
-------------------------------------------------------------
## 2.0.9-BETA
- Fixing issue with custom script - removed managed identity variables.
-------------------------------------------------------------
## 2.0.8-BETA
- Added connect-to-diagnostics-log-analytics and connect-to-diagnostics-event-hub locals to control installation of respective VM extensions. Set the values of those locals to false for the time being due to event hub permissions
- Removed unneeded install-* variables.
-------------------------------------------------------------
## 2.0.7-BETA
- Enhanced module with startup script and cloud-init features.
---------------------------------------------------------
## 2.0.4-BETA
- Updated to incorporate diagnostic logging.
---------------------------------------------------------
## 2.0.3-BETA
- Fixed issue with VM extensions not being deployed.
- Added explicit data typing on variables.
- Added the option to specify an image as either an Azure image resource or by publisher, offer, sku, and version.
---------------------------------------------------------
## 2.0.2-BETA
- Updated to use Azure image resource.
---------------------------------------------------------
## 2.0.1-BETA
- Upgrading to Terraform 0.12
---------------------------------------------------------
## 2.0.0-BETA
- Updating mandatory tags and upgrading to Terraform .12

## PROD activegate recycle - March 02 2023 -  46724673
## NPE AG recycling 07/05/2023- work item - 48182132
## PROD activegate recycle - March 02 2023 -  4827509