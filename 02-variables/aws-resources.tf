locals   {
  firstName ="sumitgupta"
}

locals   {
  name =local.firstName
}

output "firstName" {
  value = local.firstName
}

output "name" {
  value = local.name
}

## mention the provider
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.31.0"
    }
  }
}


## aws provider Configuration
provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}


## EC2 Instance aws_instance
resource "aws_instance" "front-end" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the security group
  ##vpc_security_group_ids = [aws_security_group.fornt-end-instance-security-group.id]

  tags = {for k, v in merge({ Name = var.EC2_INSTANCE_NAME_FRONT_END }, var.project_tags_front_end): k => lower(v)}
}


## create a security group.
resource "aws_security_group" "fornt-end-instance-security-group" {
  name        = "fornt-end-instance-security-group"
  description = "security group that allows ssh/http and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ## for each example
  dynamic "ingress" {
    for_each = var.portsAndCidr
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }

  tags = { for k, v in merge( { Name = "fornt-end-instance-security-group" } , var.project_tags_front_end) : k => lower(v) }
}

## A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes.
output "from_ports" {
  value = aws_security_group.fornt-end-instance-security-group.ingress[*].from_port
}

output "front-end-id" {
  value = aws_instance.front-end.id
}

output "front-end-private_ip" {
  value = aws_instance.front-end.private_ip
}

output "front-end-public_ip" {
  value = aws_instance.front-end.public_ip
}

## EC2 Instance aws_instance dev
resource "aws_instance" "front-end-dev" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  count = var.ENV == "DEV" ? 1 :0 
}

## EC2 Instance aws_instance prod
resource "aws_instance" "front-end-prod" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  count = var.ENV == "PROD" ? 2 :0 
}