data "azuread_client_config" "current" {}

resource "azuread_application" "oauth_server" {
  display_name    = "sp-id-snowflake-management-demo-oauth-server"
  owners          = [data.azuread_client_config.current.object_id]
  tags            = local.common_tags_list
  identifier_uris = []
}

resource "azuread_service_principal" "oauth_server" {
  client_id                    = azuread_application.oauth_server.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}
