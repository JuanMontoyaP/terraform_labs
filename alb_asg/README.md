# Application load balancer and an Auto-scale group

This Terraform configuration sets up an Application Load Balancer (ALB) and an Auto Scaling Group (ASG) in AWS. The ALB distributes incoming application traffic across multiple EC2 targets across two availability zones to ensure high availability and fault tolerance, while the ASG ensures that a specified number of EC2 instances are running to handle the load.

## Architecture

The following resources are going to be created:

1. A `VPC` with CIDR block of `10.0.0.0/16`
1. Two `public subnets` in two availability zones with CIDR blocks of `10.0.0.0/24` and `10.0.1.0/24`
1. Two `private subnets` in two availability zones with CIDR blocks of `10.0.2.0/24` and `10.0.3.0/24`
1. An `Application Load Balancer` on the public subnets to distribute incoming traffic across multiple targets created in EC2.
1. An `Auto Scaling Group` to manage EC2 instances in the private subnets to receive traffic from the ALB.
1. A `launch template` to define the configuration of the EC2 instances in the ASG.
1. A `target group` to register the EC2 instances as targets for the ALB.
1. Security groups for the ALB and the EC2 instances to control inbound and outbound traffic. Security group for ALB allows inbound traffic on port 80 from the internet, while the security group for EC2 instances allows inbound traffic on port 80 from the ALB security group.
1. An internet gateway and routing policies to enable internet access for the public subnets.
1. A NAT gateway for each private subnet to enable internet access for the private subnets.

![aws_architecture](./docs/alb_asg.png)

## Usage
1. Create a file called `terraform.tfvars` and specify the following variable:
    ```hcl
    aws_role_arn = "aws-role-arn"
    ```

    It is a role ARN that has sufficient permissions to create the resources defined in this configuration.

1. Run terraform plan:
    ```
    terraform plan
    ```

1. Apply the changes:
    ```
    terraform apply
    ```

For deleting all the resources created, run:
```
terraform destroy
```
