locals {
  location            = "southeastasia"
  environments        = ["dev", "stag", "prod"]
  resource_group_name = "ex-terraform-poc"
}

module "test" {
  source = "git::ssh://git@github.com/wyubin/ex_terraform.git//azure/modules/container_registry?ref=main"

  registry_name                 = "yubinatest"
  resource_group_name           = local.resource_group_name
  location                      = local.location
  public_network_access_enabled = true
}

module "registry" {
  for_each = toset(local.environments) # convert tuple to set of string

  source = "git::ssh://git@github.com/wyubin/ex_terraform.git//azure/modules/container_registry?ref=main"

  registry_name                 = "yubin${each.value}"
  resource_group_name           = local.resource_group_name
  location                      = local.location
  public_network_access_enabled = true
}
