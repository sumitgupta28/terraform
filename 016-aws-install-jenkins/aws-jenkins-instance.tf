resource "aws_instance" "jenkins-server" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-http.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  # user data
  user_data = data.template_cloudinit_config.cloudinit-startup-script.rendered

  # tags
  tags = {
    Name = "jenkins-server"
    type = "jenkins"
  }
}

