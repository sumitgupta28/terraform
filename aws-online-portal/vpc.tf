# Internet VPC
resource "aws_vpc" "sgsys-onlineportal-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name        = "sgsys-onlineportal-vpc"
    AppName = "onlineportal"
  }
}

# Public Subnets
resource "aws_subnet" "onlineportal-pub-subnet-1" {
  vpc_id                  = aws_vpc.sgsys-onlineportal-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name        = "onlineportal-pub-subnet-1"
    AppName = "onlineportal"
  }
}
# Public Subnets
resource "aws_subnet" "onlineportal-pub-subnet-2" {
  vpc_id                  = aws_vpc.sgsys-onlineportal-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name        = "onlineportal-pub-subnet-2"
    AppName = "onlineportal"
  }
}

# Private Subnets
resource "aws_subnet" "onlineportal-pri-subnet-1" {
  vpc_id                  = aws_vpc.sgsys-onlineportal-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name        = "onlineportal-pri-subnet-1"
    AppName = "onlineportal"
  }
}

resource "aws_subnet" "onlineportal-pri-subnet-2" {
  vpc_id                  = aws_vpc.sgsys-onlineportal-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name        = "onlineportal-pri-subnet-2"
    AppName = "onlineportal"
  }
}


# Internet GW
resource "aws_internet_gateway" "sgsys-onlineportal-internate-gateway" {
  vpc_id = aws_vpc.sgsys-onlineportal-vpc.id

  tags = {
    Name = "sgsys-onlineportal-internate-gateway"
  }
}

# route tables
resource "aws_route_table" "onlineportal-public-route-table" {
  vpc_id = aws_vpc.sgsys-onlineportal-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sgsys-onlineportal-internate-gateway.id
  }

  tags = {
    Name = "onlineportal-pub-subnet-1"
  }
}

# route associations pub-subnet-1
resource "aws_route_table_association" "onlineportal-rt-assoc-pub-subnet-1" {
  subnet_id      = aws_subnet.onlineportal-pub-subnet-1.id
  route_table_id = aws_route_table.onlineportal-public-route-table.id
}

# route associations pub-subnet-2
resource "aws_route_table_association" "onlineportal-rt-assoc-pub-subnet-2" {
  subnet_id      = aws_subnet.onlineportal-pub-subnet-2.id
  route_table_id = aws_route_table.onlineportal-public-route-table.id
}
