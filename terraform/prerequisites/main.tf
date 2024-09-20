data "azuread_client_config" "current" {}

resource "azuread_application" "example" {
  display_name = "sp-id-snowflake-management-demo-terraform"
  owners       = [data.azuread_client_config.current.object_id]
  tags         = local.default_tags_list
}

resource "azuread_service_principal" "example" {
  client_id                    = azuread_application.example.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}
