provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tfstate17013515"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
    access_key           = "cBWcsGSbLZ9gaNplrNs4o8iWOgJVY70CA6F3QtbuHw/shnokUOVYlMHW+Xxu8hGc83s2n39CVzI1+AStjU8zOA=="
  }
}

module "network" {
  source               = "../../modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "NET"
  resource_group       = "${var.resource_group_name}"
  address_prefixes     = "${var.address_prefixes}"
}

module "nsg-test" {
  source           = "../../modules/networksecuritygroup"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "NSG"
  resource_group   = "${var.resource_group_name}"
  subnet_id        = "${module.network.subnet_id_test}"
  address_prefix_test = "${var.address_prefix_test}"
}
module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group   = "${var.resource_group_name}"
}
module "publicip" {
  source           = "../../modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "publicip"
  resource_group   = "${var.resource_group_name}"
}

module "vm" {
  source               = "../../modules/vm"
  location             = "${var.location}"
  resource_group       = "${var.resource_group_name}"
  subnet_id            = "${module.network.subnet_id_test}"
  public_ip_address_id = "${module.publicip.public_ip_address_id}" 
  admin_username       = "${var.admin_username}"
  admin_password       = "${var.admin_password}"
  prefix               = "${var.prefix}"
}
