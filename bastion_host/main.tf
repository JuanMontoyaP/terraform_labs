terraform {
  required_version = "~> 1.13.3"

  backend "s3" {
    bucket         = "tf-labs-state-juan"
    key            = "bastion_host/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-labs-locks-juan"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = module.global.common_tags
  }
}

module "global" {
  source = "../modules/global"
}
