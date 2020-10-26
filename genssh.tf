# Create an SSH key
resource "tls_private_key" "docker_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
