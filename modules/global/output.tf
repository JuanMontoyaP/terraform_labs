# Network values
output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = local.vpc_cidr
}

output "common_tags" {
  description = "Common tags for resources"
  value       = local.common_tags
}

# Data values
output "availability_zones" {
  description = "List of available availability zones"
  value       = data.aws_availability_zones.available.names
}

output "ubuntu_ami_id" {
  description = "The most recent Ubuntu AMI ID"
  value       = data.aws_ami.ubuntu.id
}
