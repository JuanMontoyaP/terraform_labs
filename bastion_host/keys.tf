resource "tls_private_key" "bastion_host_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion_host_key" {
  key_name   = "bastion_host_key"
  public_key = tls_private_key.bastion_host_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.bastion_host_key.private_key_pem
  filename        = "${path.module}/bastion_host_key.pem"
  file_permission = "0600"
}
