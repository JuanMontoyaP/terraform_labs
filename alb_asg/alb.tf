resource "aws_lb" "alb" {
  name               = "lab-alb"
  internal           = false
  load_balancer_type = "application"
  subnets = [
    module.alb_public_subnet_1.subnet_id,
    module.alb_public_subnet_2.subnet_id
  ]
  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    "Name" = "${var.tag_prefix}_alb"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "lab-alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.alb_asg_vpc.id

  health_check {
    path              = "/"
    port              = 80
    protocol          = "HTTP"
    interval          = 30
    healthy_threshold = 2
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}
