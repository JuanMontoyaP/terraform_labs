module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpn_name
  cidr = local.vpn_cidr

  azs             = [data.aws_availability_zones.available.names[0]]
  public_subnets  = [cidrsubnet(local.vpn_cidr, 8, 0)]
  private_subnets = [cidrsubnet(local.vpn_cidr, 8, 1)]

  enable_nat_gateway = false
  single_nat_gateway = false

  tags = {
    "Name" = local.vpn_name
  }
}

resource "aws_security_group" "bastion_host" {
  name        = "bastion_host_sg"
  description = "Security group for bastion host allowing SSH access"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "bastion_host_ssh" {
  security_group_id = aws_security_group.bastion_host.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "bastion_host_egress" {
  security_group_id = aws_security_group.bastion_host.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "private_host" {
  name        = "private_host_sg"
  description = "Security group for private host allowing SSH access from bastion host"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "private_host_ssh" {
  security_group_id            = aws_security_group.private_host.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.bastion_host.id
}

resource "aws_vpc_security_group_egress_rule" "private_host_egress" {
  security_group_id = aws_security_group.private_host.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
