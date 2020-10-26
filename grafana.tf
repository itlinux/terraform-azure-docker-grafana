
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
      "curl -o /grafana/grafana.ini https://raw.githubusercontent.com/grafana/grafana/master/conf/defaults.ini",
      "curl -o /tmp/prometheus.yml https://gist.githubusercontent.com/noemi-dresden/38a63199cedaaae83a0f9f3a8ff30bd6/raw/81b22b83c67e69c971fd3d0d31d61969cd5b7fd9/prometheus.yml",
      "sudo chown -R $USER:$USER /grafana",
      "docker run -d -p 3000:3000 -uroot --name grafana -v /grafana/:/etc/grafana/ -v /grafana:/var/lib/grafana grafana/grafana",
      "docker run -d -p 9090:9090 --name prometheus -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus"
    ]
  }
  depends_on = [azurerm_linux_virtual_machine.linuxbox, null_resource.docker_install]
}