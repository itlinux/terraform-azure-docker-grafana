output public_ip {
  value = azurerm_linux_virtual_machine.linuxbox.public_ip_address
}
output coder_password {
  value = random_password.coder-password.result
}
output tls_private_key {
  value = tls_private_key.docker_ssh.private_key_pem
}
output fqdn {
  value = azurerm_public_ip.dockerpip.fqdn
}
