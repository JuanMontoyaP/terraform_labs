# Variables for AWS account configuration
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

# Variables for compute
variable "instance_type" {
  description = "The type of instance to use for the bastion host"
  type        = string
  default     = "t3.micro"
}
