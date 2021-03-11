provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}


variable "AWS_ACCESS_KEY" {
}
variable "AWS_SECRET_KEY" {
}
variable "AWS_REGION" {
}

variable "INSTANCE_TYPE" {
  default="t2.micro"
}

data "aws_ami" "free-tier" {
most_recent = true
owners = [ "amazon" ] #137112412989
  filter {
      name   = "name"
      values = ["amzn2-ami-hvm-2.0.20210303.0-x86_64-gp2"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

resource "aws_instance" "front-end" {
  ami           = data.aws_ami.free-tier.id
  instance_type = var.INSTANCE_TYPE
}
