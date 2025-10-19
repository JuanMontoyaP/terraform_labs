# Application load balancer and an Auto-scale group

This Terraform configuration sets up an Application Load Balancer (ALB) and an Auto Scaling Group (ASG) in AWS. The ALB distributes incoming application traffic across multiple EC2 targets across two availability zones to ensure high availability and fault tolerance, while the ASG ensures that a specified number of EC2 instances are running to handle the load.

## Architecture

