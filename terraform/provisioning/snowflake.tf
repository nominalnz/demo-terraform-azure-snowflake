data "snowflake_current_account" "this" {}

resource "snowflake_user" "oauth_user" {
  name         = "SNOWSQL_OAUTH_USER"
  login_name   = azuread_service_principal.oauth_client.object_id
  display_name = "SnowSQL OAuth User"
  comment      = "A system user for SnowSQL client to be used for OAuth based connectivity"
}

resource "snowflake_account_role" "snowsql_rl" {
  name = "SNOWSQL_RL"
}

resource "snowflake_grant_account_role" "snowsql_rl" {
  role_name = snowflake_account_role.snowsql_rl.name
  user_name = snowflake_user.oauth_user.name
}
