resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id                   = module.vpc.public_subnets[0]
  security_groups             = [aws_security_group.bastion_host.id]
  associate_public_ip_address = true

  user_data_base64 = base64encode(templatefile("${path.module}/user_data.sh", {
    private_key = tls_private_key.bastion_host_key.private_key_pem
  }))

  key_name = aws_key_pair.bastion_host_key.key_name

  tags = {
    "Name"    = "bastion_host",
    "Project" = module.global.common_tags["Project"]
  }
}

resource "aws_instance" "private_host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id       = module.vpc.private_subnets[0]
  security_groups = [aws_security_group.private_host.id]

  key_name = aws_key_pair.bastion_host_key.key_name

  tags = {
    "Name"    = "private_host",
    "Project" = module.global.common_tags["Project"]
  }
}
