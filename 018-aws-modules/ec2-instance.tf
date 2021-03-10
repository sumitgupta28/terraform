module "onlineportal-front-end-server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  ## instance details
  instance_count              = 1
  key_name                    = aws_key_pair.onlineportal-keypair.key_name
  name                        = "onlineportal-front-end-server"
  ami                         = var.AMIS[var.AWS_REGION]
  instance_type               = var.INSTANCE_TYPE
  subnet_ids                  = module.sgsys-onlineportal-vpc.public_subnets
  user_data                   = data.template_cloudinit_config.cloudinit-startup-script.rendered
  vpc_security_group_ids      = [module.http-security-group.this_security_group_id, module.ssh-security-group.this_security_group_id]
  associate_public_ip_address = true

  tags = {
    Name        = "onlineportal-front-end-server"
    Terraform   = "true"
    Environment = "prod"
  }
}


module "onlineportal-back-end-server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  ## instance details   
  instance_count         = 1
  key_name               = aws_key_pair.onlineportal-keypair.key_name
  name                   = "onlineportal-back-end-server"
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = var.INSTANCE_TYPE
  subnet_ids             = module.sgsys-onlineportal-vpc.private_subnets
  user_data              = data.template_cloudinit_config.cloudinit-startup-script.rendered
  vpc_security_group_ids = [module.http-security-group.this_security_group_id, module.ssh-security-group.this_security_group_id]
  #vpc_security_group_ids      = [module.ssh-security-group.this_security_group_id]
  associate_public_ip_address = false

  tags = {
    Name        = "onlineportal-back-end-server"
    Terraform   = "true"
    Environment = "prod"
  }
}