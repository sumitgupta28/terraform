
terraform {
  required_version = ">= 0.12"

  
  backend "s3" {
    bucket = "sumitgupta28-s3-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
