output "network-interface-ids" {
  value = module.virtual-machine-linux.network-interface-ids
}

/*output "certificate_data" {
  value = data.azurerm_key_vault_certificate.dynatraceagcustomhumanacert.certificate_data
}

output "thumbprint" {
  value =  data.azurerm_key_vault_certificate.dynatraceagcustomhumanacert.thumbprint
}

output "certpolicy" {
  value =  data.azurerm_key_vault_certificate.dynatraceagcustomhumanacert.certificate_policy
}*/
