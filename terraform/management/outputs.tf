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

output "azuread_application_oauth_server_client_id" {
  value = azuread_application.oauth_server.client_id
}
