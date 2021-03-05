module "sgsys-onlineportal-vpc" {
  source     = "terraform-aws-modules/vpc/aws"
  version    = "2.59.0"
  create_vpc = true
  name       = "sgsys-onlineportal-vpc"
  cidr       = "10.0.0.0/16"

  azs             = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  create_igw                        = true
  propagate_public_route_tables_vgw = true

  enable_nat_gateway = true
  enable_vpn_gateway = false

  private_acl_tags = {
    Terraform   = "true"
    Environment = "prod"
  }

  public_acl_tags  = {
    Terraform   = "true"
    Environment = "prod"
  }

  private_route_table_tags = {
    Terraform   = "true"
    Environment = "prod"
  }


  public_route_table_tags = {
    Terraform   = "true"
    Environment = "prod"
  }
  nat_eip_tags = {
    Terraform   = "true"
    Environment = "prod"
  }



  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

