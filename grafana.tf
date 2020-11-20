
resource "null_resource" "grafana" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = tls_private_key.docker_ssh.private_key_pem
      host        = azurerm_linux_virtual_machine.linuxbox.public_ip_address
      agent       = false
    }

    inline = [
      "sudo mkdir -p /grafana",
      "sudo mkdir -p /prometheus",
      "sudo chown -R $USER:$USER /grafana",
      "curl -o /grafana/grafana.ini https://raw.githubusercontent.com/itlinux/terraform-azure-docker-grafana/master/defaults.ini",
      "curl -o /tmp/prometheus.yml https://raw.githubusercontent.com/itlinux/terraform-azure-docker-grafana/master/prometheus.yml",
      "docker run -d -p 3000:3000 -uroot --name grafana -v /grafana/:/etc/grafana/ -v /grafana:/var/lib/grafana grafana/grafana",
      "docker run -d -p 9090:9090 --name prometheus -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus"
    ]
  }
  depends_on = [azurerm_linux_virtual_machine.linuxbox, null_resource.docker_install]
}
