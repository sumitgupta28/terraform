locals {
  name = "${terraform.workspace}-instance"
}

resource "aws_instance" "front-end" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the security group
  vpc_security_group_ids = [aws_security_group.instance-security-group.id]

  tags = { for k, v in merge({ Name = "front-end-${local.name}" }, var.project_tags_front_end) : k => lower(v) }


}

resource "aws_instance" "back-end" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"

  # the security group
  vpc_security_group_ids = [aws_security_group.instance-security-group.id]

  tags = { for k, v in merge({ Name = "back-end-${local.name}" }, var.project_tags_back_end) : k => lower(v) }

}