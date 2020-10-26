resource "null_resource" "docker_install" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = tls_private_key.docker_ssh.private_key_pem
      host        = azurerm_linux_virtual_machine.linuxbox.public_ip_address
      agent       = false
    }

    inline = [
      "sudo curl -sSL https://get.docker.com/ | sh",
      "sudo usermod -aG docker `echo $USER`",
      "sudo systemctl --now enable docker",
      "sudo docker run -d --name nginx -p 80:80 nginx"
    ]
  }
  depends_on = [azurerm_linux_virtual_machine.linuxbox]
}
