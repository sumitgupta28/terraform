
## A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes.

variable "PATH_TO_PRIVATE_KEY" {
  default = "my-access-key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "my-access-key.pub"
}

variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0915bcb5fa77e4892"
    us-east-2 = "ami-09246ddb00c7c4fef"
    us-west-1 = "ami-066c82dabe6dd7f73"
    us-west-2 = "ami-09c5e030f74651050"
  }
}

variable "ports" {
  type    = list(number)
  default = [22, 443, 80, 8080]
}

variable "portsAndCidr" {
  type = map(list(string))
  default = {
    "22"   = ["0.0.0.0/0"]
    "80"   = ["0.0.0.0/0"]
    "8080" = ["0.0.0.0/0"]
  }
}