module "http-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  vpc_id              = module.sgsys-onlineportal-vpc.vpc_id
  name                = "http-security-group"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "http-8080-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

module "ssh-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  vpc_id              = module.sgsys-onlineportal-vpc.vpc_id
  name                = "ssh-security-group"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}



