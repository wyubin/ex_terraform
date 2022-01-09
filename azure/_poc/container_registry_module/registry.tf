locals {
  location            = "southeastasia"
  environments        = ["dev", "stag", "prod"]
  resource_group_name = "ex-terraform-poc"
}

module "test" {
  source = "../../modules/container_registry"

  registry_name                 = "yubinatest"
  resource_group_name           = local.resource_group_name
  location                      = local.location
  public_network_access_enabled = true
}

module "registry" {
  for_each = toset(local.environments) # convert tuple to set of string

  source = "../../modules/container_registry"

  registry_name                 = "yubin${each.value}"
  resource_group_name           = local.resource_group_name
  location                      = local.location
  public_network_access_enabled = true
}
