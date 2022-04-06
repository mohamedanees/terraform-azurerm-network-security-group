output "name" {
  description = "The network security group name."
  value       = azurerm_network_security_group.nsg.name
}

output "id" {
  description = "The network security group id."
  value       = azurerm_network_security_group.nsg.id
}

output "resource_group_name" {
  description = <<EOT
The name of the resource group where the network security group is created.
EOT
  value       = azurerm_network_security_group.nsg.resource_group_name
}

output "location" {
  description = <<EOT
The location/region where the network security group is created.
EOT
  value       = azurerm_network_security_group.nsg.location
}

output "firewall_rules" {
  description = "Firewall Rules in this NSG."
  value = concat(
    azurerm_network_security_rule.predefined_rules[*],
    azurerm_network_security_rule.custom_rules[*]
  )
}