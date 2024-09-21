output "azuread_application_terraform_client_id" {
  value = azuread_application.terraform.client_id
}

output "azuread_application_terraform_password" {
  value     = azuread_application_password.terraform.value
  sensitive = true
}
