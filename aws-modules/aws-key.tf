resource "aws_key_pair" "onlineportal-keypair" {
  key_name   = "onlineportal-keypair"
  public_key = file(var.PATH_TO_PUBLIC_KEY)

  tags = {
    Name        = "onlineportal-keypair"
    Terraform   = "true"
    Environment = "prod"
  }
}

