resource "random_password" "terraform" {
  length           = 16
  special          = true
  override_special = "_%@"
}

data "azuread_domains" "example" {
  only_initial = true
}

resource "azuread_user" "terraform" {
  user_principal_name = "yubin@${data.azuread_domains.example.domains.0.domain_name}"
  display_name        = "yubin"
  password            = random_password.terraform.result
}
