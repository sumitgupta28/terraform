provider "aws" {
  region = var.AWS_REGION
}

provider "aws" {
  region = var.AWS_OREGON_REGION
  alias  = "oregon"
}
