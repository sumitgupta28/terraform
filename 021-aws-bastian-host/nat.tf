# Elastic IP Addresses
resource "aws_eip" "application-eip" {
  vpc = true
  tags = {
    Name    = "application-eip"
    AppName = "application"
  }

}

resource "aws_nat_gateway" "application-nat-gw" {
  allocation_id = aws_eip.application-eip.id
  subnet_id     = aws_subnet.application-pub-subnet-us-east-1a.id
  depends_on    = [aws_internet_gateway.sgsys-application-internate-gateway]
}

# VPC setup for NAT
resource "aws_route_table" "application-private-route-table" {
  vpc_id = aws_vpc.sgsys-application-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.application-nat-gw.id
  }

  tags = {
    Name    = "application-pri-subnet-1"
    AppName = "application"
  }
}

# route associations private
resource "aws_route_table_association" "application-rt-assoc-pri-subnet-1" {
  subnet_id      = aws_subnet.application-pri-subnet-us-east-1b.id
  route_table_id = aws_route_table.application-private-route-table.id
}