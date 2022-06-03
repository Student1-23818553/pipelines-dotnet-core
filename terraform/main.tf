data "azurerm_resource_group" "rg" {
  name = "myrg"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_mssql_server" "server" {
  name                         = "student1-23818553"
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = data.azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = random_password.password.result
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = "6045736a-0263-4c14-ac9a-faed11e12a0d"
  }
}

resource "azurerm_mssql_database" "db" {
  name           = "mydb"
  server_id      = azurerm_mssql_server.server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
}