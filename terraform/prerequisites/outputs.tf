output "terraform_client_id" {
  value = azuread_application.terraform.client_id
}

output "terraform_secret" {
  value     = azuread_application_password.terraform.value
  sensitive = true
}

output "azp_provisioner_user" {
  value = snowflake_user.azp_provisioner.name
}

output "azp_provisioner_password" {
  value     = snowflake_user.azp_provisioner.password
  sensitive = true
}

output "azp_provisioner_role" {
  value = snowflake_account_role.azp_provisioner.name
}

output "integration_management_user" {
  value = snowflake_user.integration_management.name
}

output "integration_management_password" {
  value     = snowflake_user.integration_management.password
  sensitive = true
}

output "integration_management_role" {
  value = snowflake_account_role.integration_management.name
}
