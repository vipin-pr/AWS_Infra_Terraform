#aws internet gateway resource
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "gateway-${terraform.workspace}"
  }
}

resource "aws_nat_gateway" "nat_gateway_pubic" {
  subnet_id = aws_subnet.public_subnet.id
  allocation_id = aws_eip.eip.id
  tags = {
    Name = "nat-gateway-${terraform.workspace}"
  }
  depends_on = [aws_internet_gateway.gateway]
}


# EIP for NAT Gateway in AZ A
resource "aws_eip" "eip" {
  domain   = "vpc"
  depends_on = [ aws_internet_gateway.gateway ]
  tags = {
    Name = "eip-${terraform.workspace}"
  }
}