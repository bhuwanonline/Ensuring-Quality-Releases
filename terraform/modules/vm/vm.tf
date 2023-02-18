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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/+Cw3ilCI8hYjD6yD9MAgw+c5SVKB+b6ZCWUDn1UYmkWslM6qXbszE8//cxwh46XQZrtLauxpary6sALhV1UDjbFAkFiCbQBqx/YoH23Ku7g0kBBVlEAabmRfYnxA0np4lLT0C48i7kytTn7PSj/oExLePLkrFh7J0EZBce/KKjyRoyx3eGBMdGigfLIBWNVdvp0uYvuUMbOsfjtPzyjp9sYO97Tg1s75UsXa1uZndZME6fJUd93w7AAq4MFJUxaNdwxKNnbqtbXqbKPXVwtgzn19S4rNP2Mya4EWQDK6NP0zALjO5UNRIVm9sGhyvCS0oSA84xNV2JzJNxvvODIUcTrbivue3qJHpccw+/e8eCmDN65hsv3u0lzyw9PYM256AT+1UcxkABwZpUCuemGDYqIeBI0Z0VhSWKJogRY2/OzMOusCbLQGa3E8v/yuax31yTDV2Tx9e53FOZ9+vGC9TWiErNiviG7zjF9qJn3kii6IR+hMkpus1EZVT4q85aU= bhuwaneswaran@cc-a4536acf-67599d74f8-nqv6m"   
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
