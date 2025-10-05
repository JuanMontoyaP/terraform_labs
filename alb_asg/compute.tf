resource "aws_launch_template" "server_asg_lt" {
  name_prefix            = "${var.tag_prefix}_lt_"
  image_id               = module.global.ubuntu_ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.alb_sg.id]
  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt update -y
    apt install -y apache2
    TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    INSTANCE=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
    echo "Hello, World from the Auto Scaling Group! Instance ID: $INSTANCE" > /var/www/html/index.html
    systemctl start apache2
    systemctl enable apache2
    EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.tag_prefix}_instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "server_asg" {
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  vpc_zone_identifier = [
    module.alb_public_subnet_1.subnet_id,
    module.alb_public_subnet_2.subnet_id
  ]

  launch_template {
    id      = aws_launch_template.server_asg_lt.id
    version = "$Latest"
  }

  target_group_arns         = [aws_lb_target_group.alb_tg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.tag_prefix}_asg_instance"
    propagate_at_launch = true
  }
}
