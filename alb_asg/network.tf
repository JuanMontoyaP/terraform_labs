resource "aws_vpc" "alb_asg_vpc" {
  cidr_block = module.global.vpc_cidr

  tags = {
    "Name" = "${var.tag_prefix}_vpc"
  }
}

resource "aws_internet_gateway" "alb_igw" {
  vpc_id = aws_vpc.alb_asg_vpc.id

  tags = {
    "Name" = "${var.tag_prefix}_igw"
  }
}

# Public Subnets
module "alb_public_subnet_1" {
  source            = "../modules/public_subnet"
  vpc_id            = aws_vpc.alb_asg_vpc.id
  igw_id            = aws_internet_gateway.alb_igw.id
  cidr_block        = cidrsubnet(aws_vpc.alb_asg_vpc.cidr_block, 8, 0)
  prefix            = var.tag_prefix
  availability_zone = module.global.availability_zones[0]
}

module "alb_public_subnet_2" {
  source            = "../modules/public_subnet"
  vpc_id            = aws_vpc.alb_asg_vpc.id
  igw_id            = aws_internet_gateway.alb_igw.id
  cidr_block        = cidrsubnet(aws_vpc.alb_asg_vpc.cidr_block, 8, 1)
  prefix            = var.tag_prefix
  availability_zone = module.global.availability_zones[1]
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.tag_prefix}_alb_sg"
  vpc_id      = aws_vpc.alb_asg_vpc.id
  description = "Security group for ALB"

  tags = {
    Name = "${var.tag_prefix}_alb_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb" {
  security_group_id = aws_security_group.alb_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# Private subnets
module "asg_private_subnet_1" {
  source            = "../modules/private_subnet"
  vpc_id            = aws_vpc.alb_asg_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.alb_asg_vpc.cidr_block, 8, 2)
  prefix            = var.tag_prefix
  availability_zone = module.global.availability_zones[0]
  public_subnet_id  = module.alb_public_subnet_1.subnet_id
}

module "asg_private_subnet_2" {
  source            = "../modules/private_subnet"
  vpc_id            = aws_vpc.alb_asg_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.alb_asg_vpc.cidr_block, 8, 3)
  prefix            = var.tag_prefix
  availability_zone = module.global.availability_zones[1]
  public_subnet_id  = module.alb_public_subnet_2.subnet_id
}

resource "aws_security_group" "asg_sg" {
  name        = "${var.tag_prefix}_asg_sg"
  description = "Security group for ASG instances"
  vpc_id      = aws_vpc.alb_asg_vpc.id

  tags = {
    Name = "${var.tag_prefix}_asg_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "asg_http" {
  security_group_id            = aws_security_group.asg_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "asg" {
  security_group_id = aws_security_group.asg_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
