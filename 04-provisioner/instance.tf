resource "aws_key_pair" "my-access-key" {
  key_name   = "my-access-key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "front-end" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = aws_key_pair.my-access-key.key_name

  # the security group
  vpc_security_group_ids = [aws_security_group.instance-security-group.id]

  provisioner "local-exec" {
    command = "echo ${aws_instance.front-end.private_ip} >> private_ips.txt"
  }

  # Remove the private ips. 
  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf private_ips.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf public_ips.txt"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.front-end.public_ip} >> public_ips.txt"
  }


  provisioner "local-exec" {
    command = "echo ${aws_instance.front-end.public_ip} >> public_ips.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]

  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.PATH_TO_PRIVATE_KEY)
    host        = self.public_ip
  }
}

resource "aws_security_group" "instance-security-group" {
  name        = "instance-security-group"
  description = "security group that allows ssh/http and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ## for each example
  dynamic "ingress" {
    for_each = var.portsAndCidr
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }
}

output "ec2-public-ip" {
  value = aws_instance.front-end.public_ip
}