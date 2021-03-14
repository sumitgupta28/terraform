variable "github_token" {
}


terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.5.1"
    }
  }

  backend "s3" {
    bucket = "sumitgupta28-s3-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }

}

provider "github" {
  # Configuration options
  token = var.github_token

}

