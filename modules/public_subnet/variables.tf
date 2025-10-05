variable "vpc_id" {
  description = "The ID of the VPC where the public subnet will be created"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "igw_id" {
  description = "The ID of the Internet Gateway to associate with the route table"
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
