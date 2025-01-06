terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.77.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source = "./modules/aws_vpc_module"
}

module "ec2" {
  source              = "./modules/aws_ec2_module"
  vpc_id              = module.vpc.vpc_id
  vpc_zone_identifier = module.vpc.vpc_zone_identifier_id
  public_subnet       = module.vpc.public_subnet
  availability_zone   = module.vpc.availability_zones
}

