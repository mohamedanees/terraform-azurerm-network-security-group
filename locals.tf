locals {
  predefined_rules = {
    for r in var.predefined_rules :
    r.name => {
      name                                       = r.name
      priority                                   = lookup(r, "priority", 4096 - length(var.predefined_rules) + index(var.predefined_rules, r))
      direction                                  = element(var.rules[lookup(r, "name")], 0)
      access                                     = element(var.rules[lookup(r, "name")], 1)
      protocol                                   = element(var.rules[lookup(r, "name")], 2)
      source_port_ranges                         = split(",", replace(lookup(r, "source_port_range", "*"), "*", "0-65535"))
      destination_port_range                     = element(var.rules[lookup(r, "name")], 4)
      description                                = element(var.rules[lookup(r, "name")], 5)
      source_address_prefix                      = lookup(r, "source_application_security_group_ids", null) == null && var.source_address_prefixes == null ? join(",", var.source_address_prefix) : null
      source_address_prefixes                    = lookup(r, "source_application_security_group_ids", null) == null ? var.source_address_prefixes : null
      destination_address_prefix                 = lookup(r, "destination_application_security_group_ids", null) == null && var.destination_address_prefixes == null ? join(",", var.destination_address_prefix) : null
      destination_address_prefixes               = lookup(r, "destination_application_security_group_ids", null) == null ? var.destination_address_prefixes : null
      resource_group_name                        = data.azurerm_resource_group.rg.name
      network_security_group_name                = azurerm_network_security_group.nsg.name
      source_application_security_group_ids      = lookup(r, "source_application_security_group_ids", null)
      destination_application_security_group_ids = lookup(r, "destination_application_security_group_ids", null)
    }
  }

  custom_rules = {
    for r in var.custom_rules :
    r.name => {
      name                                       = r.name
      priority                                   = lookup(r, "priority")
      direction                                  = lookup(r, "direction", "Any")
      access                                     = lookup(r, "access", "Allow")
      protocol                                   = lookup(r, "protocol", "*")
      source_port_ranges                         = split(",", replace(lookup(r, "source_port_range", "*"), "*", "0-65535"))
      destination_port_ranges                    = split(",", replace(lookup(r, "destination_port_range", "*"), "*", "0-65535"))
      source_address_prefix                      = lookup(r, "source_application_security_group_ids", null) == null && lookup(r, "source_address_prefixes", null) == null ? lookup(r, "source_address_prefix", "*") : null
      source_address_prefixes                    = lookup(r, "source_application_security_group_ids", null) == null ? lookup(r, "source_address_prefixes", null) : null
      destination_address_prefix                 = lookup(r, "destination_application_security_group_ids", null) == null && lookup(r, "destination_address_prefixes", null) == null ? lookup(r, "destination_address_prefix", "*") : null
      destination_address_prefixes               = lookup(r, "destination_application_security_group_ids", null) == null ? lookup(r, "destination_address_prefixes", null) : null
      description                                = lookup(r, "description", "Security rule for ${lookup(r, "name", "default_rule_name")}")
      resource_group_name                        = data.azurerm_resource_group.rg.name
      network_security_group_name                = azurerm_network_security_group.nsg.name
      source_application_security_group_ids      = lookup(r, "source_application_security_group_ids", null)
      destination_application_security_group_ids = lookup(r, "destination_application_security_group_ids", null)
    }
  }
}