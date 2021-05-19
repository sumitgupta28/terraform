# Internet VPC
resource "aws_vpc" "sgsys-application-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name    = "sgsys-application-vpc"
    AppName = "application"
  }
}

# Public Subnets
resource "aws_subnet" "application-pub-subnet-us-east-1a" {
  vpc_id                  = aws_vpc.sgsys-application-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name    = "application-pub-subnet-us-east-1a"
    AppName = "application"
  }
}


resource "aws_subnet" "application-pub-subnet-us-east-1b" {
  vpc_id                  = aws_vpc.sgsys-application-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name    = "application-pub-subnet-us-east-1b"
    AppName = "application"
  }
}


# Internet GW
resource "aws_internet_gateway" "sgsys-application-internate-gateway" {
  vpc_id = aws_vpc.sgsys-application-vpc.id

  tags = {
    Name = "sgsys-application-internate-gateway"
  }
}

# route tables
resource "aws_route_table" "application-public-route-table" {
  vpc_id = aws_vpc.sgsys-application-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sgsys-application-internate-gateway.id
  }

  tags = {
    Name = "aws_route_table"
  }
}

# route associations pub-subnet-1
resource "aws_route_table_association" "application-rt-assoc-pub-subnet-1" {
  subnet_id      = aws_subnet.application-pub-subnet-us-east-1a.id
  route_table_id = aws_route_table.application-public-route-table.id
}

resource "aws_route_table_association" "application-rt-assoc-pub-subnet-2" {
  subnet_id      = aws_subnet.application-pub-subnet-us-east-1b.id
  route_table_id = aws_route_table.application-public-route-table.id
}
