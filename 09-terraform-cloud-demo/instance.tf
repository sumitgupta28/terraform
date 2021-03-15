

resource "aws_instance" "ec2-server" {
  ami= "ami-038f1ca1bd58a5790"
  instance_type= "t2.micro"
  tags = {
    Name ="ec2-server"
  }
}

