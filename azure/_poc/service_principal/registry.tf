terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65.0"
    }
  }
}

module "registry" {
  source = "git::ssh://git@github.com/wyubin/ex_terraform.git//azure/modules/azuread_service_principal?ref=main"

  service_principal_name               = "yubin-azure-test"
  enable_service_principal_certificate = true
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_certificate)
  certificate_path           = "/home/yubin/.ssh/yubin-azure-test.crt"
  password_rotation_in_years = 1

  # Adding roles to service principal
  # The principle of least privilege
  role_definition_names = [
    "Contributor"
  ]
}
