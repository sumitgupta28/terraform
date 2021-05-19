data "template_file" "shell-script" {
  template = file("scripts/install-apache.sh")
}

data "template_cloudinit_config" "cloudinit-startup-script" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell-script.rendered
  }
}


resource "aws_key_pair" "application-keypair" {
  key_name   = "mykeypair"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_security_group" "allow-ssh" {
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  vpc_id      = aws_vpc.sgsys-application-vpc.id


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
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "allow-ssh-security-group"
    AppName = "application"

  }
}


resource "aws_instance" "application-server-us-east-1a" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  #count = 1

  # the VPC subnet
  subnet_id = aws_subnet.application-pub-subnet-us-east-1a.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.application-keypair.key_name

  # user data
  user_data = data.template_cloudinit_config.cloudinit-startup-script.rendered

  # tags
  tags = {
    Name    = "application-server"
    AppName = "application"
  }
}

##application-front-end-server
output "application-server-us-east-1a-public_ip" {
  value = aws_instance.application-server-us-east-1a.public_ip
}



resource "aws_instance" "application-pub-subnet-us-east-1b" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  #count = 1

  # the VPC subnet
  subnet_id = aws_subnet.application-pub-subnet-us-east-1b.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.application-keypair.key_name

  # user data
  user_data = data.template_cloudinit_config.cloudinit-startup-script.rendered

  # tags
  tags = {
    Name    = "application-server"
    AppName = "application"
  }
}

##application-front-end-server
output "application-pub-subnet-us-east-1b-public_ip" {
  value = aws_instance.application-pub-subnet-us-east-1b.public_ip
}