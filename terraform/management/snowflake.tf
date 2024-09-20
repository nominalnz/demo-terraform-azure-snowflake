resource "snowflake_user" "useradmin" {
  name = "USERADMIN_USER"
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

resource "snowflake_grant_account_role" "useradmin" {
  role_name = "USERADMIN"
  user_name = snowflake_user.useradmin.name
}
