locals {
  location            = "southeastasia"
  environment         = "dev"
  resource_group_name = "ex-terraform-poc"
}

# https://github.com/Azure/terraform-azurerm-compute
module "linuxservers" {
  source = "Azure/compute/azurerm"

  resource_group_name = local.resource_group_name

  vm_hostname  = "yubin-for-test"
  vm_size      = "Standard_DC1s_v2" # azure free plan
  vm_os_simple = "UbuntuServer"
  vm_os_sku = "18_04-lts-gen2"
  ssh_key = "~/.ssh/id_ed25519.pub"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  vnet_subnet_id = module.network.vnet_subnets[0]

  tags = {
    environment = local.environment
  }
}

# https://github.com/Azure/terraform-azurerm-network
module "network" {
  source = "Azure/network/azurerm"

  resource_group_name = local.resource_group_name

  address_space   = "10.2.0.0/16"
  subnet_prefixes = ["10.2.1.0/24"]
  subnet_names    = ["subnet-test-compute"]

  tags = {
    environment = local.environment
  }
}
