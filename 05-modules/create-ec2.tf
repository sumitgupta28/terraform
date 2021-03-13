variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}


module "aws_instance_ec2" {
  source = "./modules/ec2"
  instance_type=var.instance_type
}