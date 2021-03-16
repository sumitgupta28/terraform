resource "aws_instance" "ec2" {
  ami           = "ami-0915bcb5fa77e4892"
  instance_type = var.instance_type
}

output "aws_instance_ec2_public_ip" {
  value = aws_instance.ec2.public_ip
}

output "aws_instance_ec2_private_ip" {
  value = aws_instance.ec2.private_ip
}