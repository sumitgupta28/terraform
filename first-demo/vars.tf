variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-047a51fa27710816e"
    us-east-2 = "ami-01aab85a5e4a5a0fe"
    us-west-1 = "ami-005c06c6de69aee84"
    us-west-2 = "ami-0e999cbd62129e3b1"

  }
}
