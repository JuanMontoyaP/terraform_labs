resource "aws_vpc" "alb_asg_vpc" {
  cidr_block = module.global.vpc_cidr

  tags = {
    Name = "alb_asg_vpc"
  }
}

module "public_subnet_1" {
  source       = "../modules/public_subnet"
  vpc_id       = aws_vpc.alb_asg_vpc.id
  cidr_block   = cidrsubnet(aws_vpc.alb_asg_vpc.cidr_block, 8, 0)
  project_name = module.global.common_tags["Project"]
}

module "public_subnet_2" {
  source       = "../modules/public_subnet"
  vpc_id       = aws_vpc.alb_asg_vpc.id
  cidr_block   = cidrsubnet(aws_vpc.alb_asg_vpc.cidr_block, 8, 1)
  project_name = module.global.common_tags["Project"]
}
