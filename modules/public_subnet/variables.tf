variable "vpc_id" {
  description = "The ID of the VPC where the public subnet will be created"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "project_name" {
  description = "Project tag for resources"
  type        = string
}
