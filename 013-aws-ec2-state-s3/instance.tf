resource "aws_instance" "front-end" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  
  # the security group
  vpc_security_group_ids = [aws_security_group.instance-security-group.id]

  tags = {for k, v in merge({ Name = "front-end" }, var.project_tags_front_end): k => lower(v)}


}
