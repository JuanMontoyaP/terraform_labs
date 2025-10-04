resource "aws_launch_template" "server_lt" {
  name          = "server_lt"
  image_id      = module.global.ubuntu_ami_id
  instance_type = var.instance_type

  user_data = templatefile("${path.module}/user_data.sh", {
    private_key = tls_private_key.server_key.private_key_pem
  })

  key_name = aws_key_pair.server_key.key_name

  vpc_security_group_ids = [aws_security_group.server_sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "server_instance"
    }
  }
}
