# Variables for AWS account configuration
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS profile to use for authentication"
  type        = string
}

# Variables for compute
variable "instance_type" {
  description = "The type of instance to use for the bastion host"
  type        = string
  default     = "t3.micro"
}

variable "user_arn" {
  description = "The ARN of the user to allow SSH access to the bastion host"
  type        = string

}
