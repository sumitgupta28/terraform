resource "aws_instance" "onlineportal-front-end-server" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.onlineportal-pub-subnet-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.onlineportal-security-group-ssh.id,aws_security_group.onlineportal-security-group-tcp.id]

  # the public SSH key
  key_name = aws_key_pair.onlineportal-keypair.key_name

  # user data
  user_data = data.template_cloudinit_config.cloudinit-startup-script.rendered

  # tags
  tags = {
    Name        = "onlineportal-front-end-server"
    AppName = "onlineportal"
  }
}

resource "aws_instance" "onlineportal-bastion-host" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.onlineportal-pub-subnet-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.onlineportal-security-group-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.onlineportal-keypair.key_name

  # user data
  user_data = data.template_cloudinit_config.cloudinit-startup-script.rendered

  # tags
  tags = {
    Name        = "onlineportal-bastion-host"
    AppName = "onlineportal"
  }
}

resource "aws_instance" "onlineportal-back-end-server" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.onlineportal-pri-subnet-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.onlineportal-security-group-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.onlineportal-keypair.key_name

  # user data
  user_data = data.template_cloudinit_config.cloudinit-startup-script.rendered

  # tags
  tags = {
    Name        = "onlineportal-back-end-server"
    AppName = "onlineportal"
  }
}
