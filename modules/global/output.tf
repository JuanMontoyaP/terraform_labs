# Network values
output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = local.vpc_cidr

}

output "common_tags" {
  description = "Common tags for resources"
  value       = local.common_tags
}
