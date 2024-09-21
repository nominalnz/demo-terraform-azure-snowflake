resource "random_password" "azp_provisioner" {
  length  = 16
  special = false
}

resource "snowflake_user" "azp_provisioner" {
  name     = "AZP_PROVISIONER_USER"
  password = random_password.azp_provisioner.result
}

resource "snowflake_account_role" "azp_provisioner" {
  name = "AZP_PROVISIONER"
}

resource "snowflake_grant_account_role" "azp_provisioner" {
  role_name = snowflake_account_role.azp_provisioner.name
  user_name = snowflake_user.azp_provisioner.name
}

resource "snowflake_grant_account_role" "_azp_provisioner" {
  role_name        = snowflake_account_role.azp_provisioner.name
  parent_role_name = "ACCOUNTADMIN"
}
