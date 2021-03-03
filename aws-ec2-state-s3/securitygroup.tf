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
    for_each=var.portsAndCidr
    content{
    from_port   = ingress.key
    to_port     = ingress.key
    protocol    = "tcp"
    cidr_blocks = ingress.value
    }
  }
}


