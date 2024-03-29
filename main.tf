/**
* ---
* title: "Azure Linux Virtual Machine Terraform Module"
* date: 2019-05-10T11:02:05+06:00
* author: "innovate@humana.com"
* ---
*
* ## Information
* 
* Humana Quick start sample to showcase usage of EA Reference architecture template for Azure Linux Virtual Machines.
* 
* ### Prerequisites
* 
* 1. Have access to VSTS
* 2. Have access to correct Azure resource group
* 3. Have access with Azure DevOps pipeline that has terraform account allowed to create resources
* 4. Have access to the already created storage account to connect it with VM for the diagnostics.
* 5. Have access to the already created virtual network to create the VM in the network. Make sure that location of VM is same as the location of the Virtual network.
* 6. Have obtained the workspace ID & Key from the Log Analytics Workspace "cdaops-ws" and stored them in a Key Vault in the same subscription that you are deploying your VM too.
* 7. Have access to a Recovery Services Vault within the same subscription for configuring VM backups.
*
* No need to install Terraform locally.
*     $ Repo Name : Ref.Cloud.Azure.Example.VMLinux
*     
* 
* ### Usage Information
* 
* #### When to Use?
*
*   This is the quick start sample code to consume Golden terraform template. In this example developed by the EA team. Every Humana personnel involved in application development for the cloud will have the ability to clone this repo. 
*   If you are part of the app development team and your application has a need to use Azure Funcions service, then you can make use
*   of this sample code.  
*
* #### Azure Linux VM functions supported
*
* - Creating one or more Linux VMs with a specific size
* - Create a network interface for the VM
* - Create data disks attached to the VM
* - Configuring the VM's boot diagnostics to be stored into a storage account.
* - Configuring the VM to be backed up on a schedule into a Recovery Services Vault.
*
* #### How to use?
*
*   EA team has created a Quick start sample code to help speed up your development process. 
*       $ Repo Name : Ref.Cloud.Azure.Example.VMLinux
*   Please clone this repo and follow your application naming convention on naming repositories and create the necessary cloud 
*   services. Once you clone and create a repo, you own the code base. Following the terraform best practices, values to all variables
*   must be specified in the .tfvars file. EA team has created a set standard .tfvars file in conforming to the best practices.
*   
*               $ <env>-backend.tfvars 
*               $ <env>-VMLinux.tfvars
*   For eg: dev-backend.tfvars , prd-backend.tfvars. The backend tfvars holds the name of the bucket to store your terraform state.
*           You can do a reading on tfstate, but to give you guidance, just replace the environment name in the bucket and the repo
*           name in the prefix. You team, or the service account that is executing your release pipeline should have access to this
*           storage account to create/modify objects. Please reach out to you application lead for clarification.
*           dev-VMLinux.tfvars, prd-VMLinux.tfvars. This file holds the values for the VM Linux attributes such as VM name, vnet and subnet,
*           number of VMs to create, VM size, OS image, computer name, types and sizes of disks, admin credentials, diagnostics settings,
*           backup settings, mandatory labels, etc. Please use the standard naming convention for variables in the respective variables.tf. Please
*           refer to the naming conventions standards. For a complete list of Input, Output parameters please check the parameters section.
*
*   The VMLinux module is designed to work in coordination with the Recovery Services Vault and Labels modules. Set the recovery-vault-name
*   and recovery-vault-resource-group-name variables to the name and resource group of a Recovery Services Vault within the same subscription
*   and Azure region as the VM being deployed. The value of the recovery-vault-backup-policy-set variable must correspond with the value of the
*   policy-set-name variable used to create the Recovery Services Vault. By default, the value of the recovery-vault-backup-policy-set variable
*   is "vm-backup-policy", but if a different policy-set-name was used to configure the Recovery Services Vault, then the recovery-vault-backup-policy-set
*   variable will need to be set with that name instead. The VMLinux module uses the value of the "environment" tag within the tags variable
*   to match the VM with a backup policy within the Recovery Services Vault. The VMLinux module combines the environment and policy set together
*   in the form of {environment}-{policy set}, so if the recovery-vault-backup-policy-set variable is "vm-backup-policy" and the environment tag
*   is "dev", then the VMLinux module will match the VM with the backup policy named "dev-vm-backup-policy".
*
* ### Resiliency
*   
* Please refer to the Azure Reference (https://docs.microsoft.com/en-us/azure/virtual-machines/) for a complete documentation. 
* 
*
* ### Support
*
*   This is a reference template following the enterprise and industry wide best practices. You are allowed to use the code as 
*   prescribed to create resources. Please direct all your concerns to your application lead. The application team is responsible
*   for all applications developed using this template. Please follow the contact procedure to reach out to the appropriate personnel
*   should you have any concern, feedback and need clarification. The contact information is available in the contact section.
* 
* ### Contact
*
*     [Email innovate@humana.com](mailto:innovate@humana.com)
* 
* ### Humana Disposition
*
*     Stage: Emerging Early Access
*
*/



terraform {
  backend "remote" {
    organization = "humanaprd"

    workspaces {
      prefix = "Azure-EMF-AZ1Hub-"
    }
  }
}
