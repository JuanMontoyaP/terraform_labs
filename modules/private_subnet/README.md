# Private Subnet Module

This Terraform module creates a private subnet within a specified VPC, along with an associated route table and a NAT gateway to enable outbound internet access for resources within the private subnet. The module requires the ID of an existing VPC and a public subnet in the same availability zone to host the NAT gateway.
