resource "aws_key_pair" "my-access-key" {
  key_name   = "my-access-key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "front-end" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = aws_key_pair.my-access-key.key_name


  provisioner "local-exec" {
    command = "echo ${aws_instance.front-end.private_ip} >> private_ips.txt"
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

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.PATH_TO_PRIVATE_KEY)
      host        = self.public_ip
    }
  }

}

output "ec2-public-ip" {
  value = aws_instance.front-end.public_ip
}