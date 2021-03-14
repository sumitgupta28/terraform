variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "ENV" {
  default= "DEV"
}
variable "INSTANCE_TYPE" {
  default="t2.micro"
}





variable "ports" {
  type= list(number)
  default =[22,443,80,8080]
}

variable "portsAndCidr" {
  type= map(list(string))
  default = {
    "22" = ["0.0.0.0/0"]
    "443" = ["0.0.0.0/0"]
    "80" = ["0.0.0.0/0","127.0.0.1/32"]
    "8080"= ["0.0.0.0/0"]
  }
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

variable "RDS_PASSWORD" {
  type        = string
  description = "Password for Database."
  default="randomPassword12334"
  validation {
    condition     = length(var.RDS_PASSWORD) > 8 
    error_message = "Password length Must be greater then 8."
  }
}


variable "project_tags_front_end" {
  type          = map(string)
  default       = {
    component   = "Frontend"
  }
}

variable "project_tags_back_end" {
  type          = map(string)
  default       = {
    component   = "backend"
  }
}