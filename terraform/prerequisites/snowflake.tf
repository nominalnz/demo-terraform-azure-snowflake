##################################################################################################
# Azure Service Principal Provisioner
##################################################################################################

resource "random_password" "azp_provisioner" {
  length  = 16
  special = false
}

resource "snowflake_user" "azp_provisioner" {
  name         = "AZP_PROVISIONER_USER"
  login_name   = "AZP_PROVISIONER_USER"
  display_name = "AZP_PROVISIONER_USER"
  password     = random_password.azp_provisioner.result
}

resource "snowflake_account_role" "azp_provisioner" {
  name = "AZP_PROVISIONER"
}

resource "snowflake_grant_privileges_to_account_role" "azp_provisioner" {
  privileges        = ["CREATE USER", "CREATE ROLE"]
  account_role_name = snowflake_account_role.azp_provisioner.name
  on_account        = true
}

resource "snowflake_grant_account_role" "azp_provisioner" {
  role_name = snowflake_account_role.azp_provisioner.name
  user_name = snowflake_user.azp_provisioner.name
}

resource "snowflake_grant_account_role" "_azp_provisioner" {
  role_name        = snowflake_account_role.azp_provisioner.name
  parent_role_name = "ACCOUNTADMIN"
}

##################################################################################################
# Integration
##################################################################################################

resource "random_password" "integration" {
  length  = 16
  special = false
}

resource "snowflake_user" "integration" {
  name         = "INTEGRATION_USER"
  login_name   = "INTEGRATION_USER"
  display_name = "INTEGRATION_USER"
  password     = random_password.integration.result
}

resource "snowflake_account_role" "integration" {
  name = "INTEGRATION"
}

resource "snowflake_grant_privileges_to_account_role" "integration" {
  privileges        = ["CREATE INTEGRATION"]
  account_role_name = snowflake_account_role.integration.name
  on_account        = true
}

resource "snowflake_grant_account_role" "integration" {
  role_name = snowflake_account_role.integration.name
  user_name = snowflake_user.integration.name
}

resource "snowflake_grant_account_role" "_integration" {
  role_name        = snowflake_account_role.integration.name
  parent_role_name = "ACCOUNTADMIN"
}
