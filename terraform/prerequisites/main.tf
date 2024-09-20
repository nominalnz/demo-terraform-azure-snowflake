data "azuread_client_config" "current" {}

data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
}

resource "azuread_application" "terraform" {
  display_name = "sp-id-snowflake-management-demo-terraform"
  owners       = [data.azuread_client_config.current.object_id]
  tags         = local.common_tags_list

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]

    resource_access {
      id   = data.azuread_service_principal.msgraph.app_role_ids["Application.ReadWrite.OwnedBy"]
      type = "Role"
    }
  }
}

resource "azuread_service_principal" "terraform" {
  client_id                    = azuread_application.terraform.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

# Grant Admin Consent
resource "azuread_app_role_assignment" "msgraph_application_readwrite_ownedby" {
  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids["Application.ReadWrite.OwnedBy"]
  principal_object_id = azuread_service_principal.terraform.object_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}

# Access Terraform State files
data "azurerm_storage_account" "tfstate" {
  name                = "stnmnllztfstate"
  resource_group_name = "rg-management"
}

resource "azurerm_role_assignment" "tfstate_account_reader" {
  role_definition_name = "Reader and Data Access"
  scope                = data.azurerm_storage_account.tfstate.id
  principal_id         = azuread_service_principal.terraform.id
}

data "azurerm_storage_container" "tfstate" {
  name                 = "snowflake-management-demo"
  storage_account_name = "stnmnllztfstate"
}

resource "azurerm_role_assignment" "tfstate_container_contributor" {
  role_definition_name = "Storage Blob Data Contributor"
  scope                = data.azurerm_storage_container.tfstate.resource_manager_id
  principal_id         = azuread_service_principal.terraform.id
}
