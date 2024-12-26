#aws vpc resource
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = "vpc-${terraform.workspace}"
  }
}

#aws internet gateway resource
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "gateway-${terraform.workspace}"
  }
}


#aws private subnet resource
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr_block
  map_public_ip_on_launch = false # Private subnet

  tags = {
    Name = "private-subnet-${terraform.workspace}"
  }
}

#aws public subnet resource
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr_block

  tags = {
    Name = "public-subnet-${terraform.workspace}"
  }
}

#aws public route table resource
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }
  tags = {
    Name = "public-subnet-route-table-${terraform.workspace}"
  }
}

#aws private subnet resource
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "private-subnet-route-table-${terraform.workspace}"
  }
}

# route table association for private subnet
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# route table association for public subnet
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "NAT-gateway-${terraform.workspace}"
  }

  depends_on = [aws_internet_gateway.gateway]
}


