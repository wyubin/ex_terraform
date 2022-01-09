resource "azurerm_container_registry" "acr" {
  name                          = "containerRegistry0261144a3692e6d8"
  resource_group_name           = "ex-terraform-poc"
  location                      = "southeastasia"
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = true
  dynamic "georeplications" {
    for_each = var.georeplications
    content {
      location                = georeplications.value["location"]
      zone_redundancy_enabled = georeplications.value["zone_redundancy_enabled"]
      tags                    = georeplications.value["tags"]
    }
  }
}
