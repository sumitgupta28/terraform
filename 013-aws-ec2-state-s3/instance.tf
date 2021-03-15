resource "aws_instance" "front-end" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  
  # the security group
  vpc_security_group_ids = [aws_security_group.instance-security-group.id]

  tags = {for k, v in merge({ Name = "front-end" }, var.project_tags_front_end): k => lower(v)}
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
    for_each=var.portsAndCidr
    content{
    from_port   = ingress.key
    to_port     = ingress.key
    protocol    = "tcp"
    cidr_blocks = ingress.value
    }
  }
}
