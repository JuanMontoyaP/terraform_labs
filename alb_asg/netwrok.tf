resource "aws_vpc" "alb_asg_vpc" {
  cidr_block = module.global.vpc_cidr

  tags = {
    Name = "alb_asg_vpc"
  }
}
