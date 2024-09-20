locals {
  default_tags = {
    ManagedBy = "Terraform"
    GitRepo   = "https://github.com/nominalnz/demo-terraform-azure-snowflake"
  }

  default_tags_list = [for key, value in local.default_tags : "${key}=${value}"]
}
