# Elastic IP Addresses
resource "aws_eip" "onlineportal-eip" {
  vpc = true
  tags = {
    Name    = "onlineportal-eip"
    AppName = "onlineportal"
  }

}

resource "aws_nat_gateway" "onlineportal-nat-gw" {
  allocation_id = aws_eip.onlineportal-eip.id
  subnet_id     = aws_subnet.onlineportal-pub-subnet-1.id
  depends_on    = [aws_internet_gateway.sgsys-onlineportal-internate-gateway]
}

# VPC setup for NAT
resource "aws_route_table" "onlineportal-private-route-table" {
  vpc_id = aws_vpc.sgsys-onlineportal-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.onlineportal-nat-gw.id
  }

  tags = {
    Name    = "onlineportal-pri-subnet-1"
    AppName = "onlineportal"
  }
}


# route associations private
resource "aws_route_table_association" "onlineportal-rt-assoc-pri-subnet-1" {
  subnet_id      = aws_subnet.onlineportal-pri-subnet-1.id
  route_table_id = aws_route_table.onlineportal-private-route-table.id
}

resource "aws_route_table_association" "onlineportal-rt-assoc-pri-subnet-2" {
  subnet_id      = aws_subnet.onlineportal-pri-subnet-2.id
  route_table_id = aws_route_table.onlineportal-private-route-table.id
}