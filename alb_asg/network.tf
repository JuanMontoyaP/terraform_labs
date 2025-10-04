resource "aws_vpc" "alb_asg_vpc" {
  cidr_block = module.global.vpc_cidr

  tags = {
    Name = "alb_asg_vpc"
  }
}

resource "aws_internet_gateway" "alb_asg_igw" {
  vpc_id = aws_vpc.alb_asg_vpc.id

  tags = {
    Name = "alb_asg_igw"
  }
}

module "public_subnet_1" {
  source     = "../modules/public_subnet"
  vpc_id     = aws_vpc.alb_asg_vpc.id
  cidr_block = cidrsubnet(aws_vpc.alb_asg_vpc.cidr_block, 8, 0)
  igw_id     = aws_internet_gateway.alb_asg_igw.id
}

module "public_subnet_2" {
  source     = "../modules/public_subnet"
  vpc_id     = aws_vpc.alb_asg_vpc.id
  cidr_block = cidrsubnet(aws_vpc.alb_asg_vpc.cidr_block, 8, 1)
  igw_id     = aws_internet_gateway.alb_asg_igw.id
}
