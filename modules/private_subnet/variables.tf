variable "vpc_id" {
  description = "The ID of the VPC where the subnet will be created"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "prefix" {
  description = "A prefix to use for all resource names"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the subnet"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet to associate with the NAT gateway (Must be in the same AZ as this private subnet)"
  type        = string
}
