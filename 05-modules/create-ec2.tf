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

output "aws_instance_ec2_public_ip" {
  ##module.<MODULE NAME>.<OUTPUT NAME>    
  value = module.aws_instance_ec2.aws_instance_ec2_public_ip
}

output "aws_instance_ec2_private_ip" {
  ##module.<MODULE NAME>.<OUTPUT NAME>    
  value = module.aws_instance_ec2.aws_instance_ec2_private_ip
}
