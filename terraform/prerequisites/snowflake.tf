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
# Integration Management
##################################################################################################

resource "random_password" "integration_management" {
  length  = 16
  special = false
}

resource "snowflake_user" "integration_management" {
  name         = "INTEGRATION_MANAGEMENT_USER"
  login_name   = "INTEGRATION_MANAGEMENT_USER"
  display_name = "INTEGRATION_MANAGEMENT_USER"
  password     = random_password.integration_management.result
}

resource "snowflake_account_role" "integration_management" {
  name = "INTEGRATION_MANAGEMENT"
}

resource "snowflake_grant_privileges_to_account_role" "integration_management" {
  privileges        = ["CREATE INTEGRATION"]
  account_role_name = snowflake_account_role.integration_management.name
  on_account        = true
}

resource "snowflake_grant_account_role" "integration_management" {
  role_name = snowflake_account_role.integration_management.name
  user_name = snowflake_user.integration_management.name
}

resource "snowflake_grant_account_role" "_integration_management" {
  role_name        = snowflake_account_role.integration_management.name
  parent_role_name = "ACCOUNTADMIN"
}
