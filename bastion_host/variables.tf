# Variables for AWS account configuration
variable "aws_role_arn" {
  description = "The ARN of the role to assume for AWS operations"
  type        = string

  validation {
    condition     = can(regex("^arn:aws:iam::[0-9]{12}:role/", var.aws_role_arn))
    error_message = "The role ARN must be a valid IAM role ARN format."
  }
}

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
