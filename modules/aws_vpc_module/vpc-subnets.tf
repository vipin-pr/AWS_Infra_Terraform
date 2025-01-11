#aws vpc resource
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = "vpc-${terraform.workspace}"
  }
}

#aws private subnet resource
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr_block
  map_public_ip_on_launch = false # Private subnet
  # availability_zone[0] = us-east-1a
  availability_zone = var.availability_zone[0] 

  tags = {
    Name = "private-subnet-${terraform.workspace}"
  }
}

#aws public subnet resource
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr_block
  # availability_zone[1] = us-east-1b
  availability_zone = var.availability_zone[0]
  tags = {
    Name = "public-subnet-${terraform.workspace}"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr_block_2
  # availability_zone[1] = us-east-1c
  availability_zone = var.availability_zone[1]
  tags = {
    Name = "public-subnet-2-${terraform.workspace}"
  }
}