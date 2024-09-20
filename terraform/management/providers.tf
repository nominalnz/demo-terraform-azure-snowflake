terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.96.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.53.1"
    }
  }
}

provider "snowflake" {
  role = "ACCOUNTADMIN"
}
