resource "random_password" "azp_provisioner" {
  length  = 16
  special = false
}

resource "snowflake_user" "azp_provisioner" {
  name     = "AZP_PROVISIONER"
  password = random_password.azp_provisioner.result
}

# data "snowflake_roles" "useradmin" {
#   like = "USERADMIN"
# }

# output "snowflake_roles_useradmin_output" {
#   value = data.snowflake_roles.useradmin.roles
# }

# resource "snowflake_grant_account_role" "useradmin" {
#   role_name = data.snowflake_roles.useradmin.roles[0].show_output[0].name
#   user_name = snowflake_user.useradmin.name
# }

resource "snowflake_grant_account_role" "azp_provisioner_useradmin" {
  role_name = "USERADMIN"
  user_name = snowflake_user.azp_provisioner.name
}
