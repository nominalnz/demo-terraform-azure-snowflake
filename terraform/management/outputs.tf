output "azp_provisioner_password" {
  value     = snowflake_user.azp_provisioner.password
  sensitive = true
}
