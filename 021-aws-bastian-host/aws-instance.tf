resource "aws_key_pair" "application-keypair" {
  key_name   = "mykeypair"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_security_group" "allow-ssh" {
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  vpc_id = aws_vpc.sgsys-application-vpc.id


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
    Name    = "allow-ssh-security-group"
    AppName = "application"

  }
}


resource "aws_instance" "application-bastion-host" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.application-pub-subnet-us-east-1a.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.application-keypair.key_name

  # tags
  tags = {
    Name    = "application-bastion-host"
    AppName = "application"
  }
}

##application-front-end-server
output "application-bastion-host-public_ip" {
  value = aws_instance.application-bastion-host.public_ip
}


##application-back-end-server on private subnet
resource "aws_instance" "application-back-end-server" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.application-pri-subnet-us-east-1b.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.application-keypair.key_name

  # tags
  tags = {
    Name    = "application-back-end-server"
    AppName = "application"
  }
}


##application-front-end-server
output "application-backend-server-private_ip" {
  value = aws_instance.application-back-end-server.private_ip
}
