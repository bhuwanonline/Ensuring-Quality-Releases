resource "azurerm_network_interface" "test" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}


resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.prefix}-vm"
  location            = var.location
  resource_group_name = var.resource_group
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.test.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/19Z03GasarQ9p23qmxcAxzAEeSE2gqZYyOHJBPCmadIOleE1/cGk6YJBL2Lgs38or7+tETVDq33tDQGSIn/XjFzMh2TGWxAt12b3r7NMfILuPYrByQuZmYyNo8ksTG0w/+yRKE5K3iewwwrx1hzioJmLb9iradW7n/8tu5V2sam1GX6RblVN1mXK0cUxOUYNVDPQt3pRvCgfDEbKg4BOoDCLRkyIslE0iWn+M4l54wI9hCaMgatMfwvx8g8QZZPFRO9vmsz6PmtP3yZ/e4PXKSmxhM/Vvm2Q4ZK9eYa44FJNdM1xcjbE6KHglgjwyczWC/iAxdAt99JKeF2OilXrpKFrGD65A7XyJL+zLMONHWMi4KHf1m16GLn0c35IEtL+LEY+D/syt7m8Fm7AKbZ5s5Z7pMCnwkmuRtyI5h/vJ8KBxhyFCP3ZdchtkDQNBOeFgn6TmT7PXk8IM7z/ZWtioAT+E//r9N18lpW1P0Us1m+lTLEIIfRfaO8Q3OaK8tk= bhuwaneswaran@cc-e604c6cd-85d5cd45c9-rn8qc"   
  }

 
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}