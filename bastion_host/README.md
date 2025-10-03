# Bastion host in AWS

Terraform lab for creating a ec2 bastion hosts in a public subnet that is able to connect to ec2 instances over ssh in a private subnet.

## Architecture

The following resources are going to be created:

1. A `VPC` with CIDR block of `10.0.0.0/16`.
1. A `public subnet` with CIDR block of `10.0.0.0/24`.
1. A `private subnet` with CIDR block of `10.0.1.0/24`.
1. A `public security group` that allows traffic to port `22` from all over the internet.
1. A `private security group` that allows traffic to port `22` from only the `public security group`.
1. Two EC2 instances, one in the public subnet (bastion host or jump host) and another one in the private subnet.

![aws_architecture](./docs/bastion_hosts_aws.png)

P.D. The `VPC` module used here also creates another network resources like internet gateway, routing policies, etc. that are not listed and represented here.

## Usage
1. Create a file called `terrafrom.tfvars` and specify the following two variables:
    ```
    aws_region  = "aws-region"
    aws_profile = "aws-profile"
    ```

1. Run terraform plan:
    ```
    terraform plan
    ```

1. Apply the changes:
    ```
    terraform apply
    ```
