resource "aws_security_group" "onlineportal-security-group-ssh" {
  vpc_id      = aws_vpc.sgsys-onlineportal-vpc.id
  name        = "onlineportal-security-group-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "onlineportal-security-group-ssh"
    AppName = "onlineportal"
  }
}


resource "aws_security_group" "onlineportal-security-group-tcp" {
  vpc_id      = aws_vpc.sgsys-onlineportal-vpc.id
  name        = "onlineportal-security-group-tcp"
  description = "security group that allows http and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "onlineportal-security-group-tcp"
    AppName = "onlineportal"
  }
}
