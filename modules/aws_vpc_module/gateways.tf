#aws internet gateway resource
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "gateway-${terraform.workspace}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id         = aws_subnet.public_subnet.id
  connectivity_type = "public"
  depends_on = [aws_internet_gateway.gateway]

  tags = {
    Name = "NAT-gateway-${terraform.workspace}"
  }

}