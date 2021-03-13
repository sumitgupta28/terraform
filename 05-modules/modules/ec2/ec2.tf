resource "aws_instance" "ec2" {
  ami           = "ami-0915bcb5fa77e4892"
  instance_type = var.instance_type
}
