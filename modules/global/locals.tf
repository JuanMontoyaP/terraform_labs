locals {
  # Network
  vpc_cidr = "10.0.0.0/16"

  # Tags
  common_tags = {
    Project = "terraform_labs"
  }
}
