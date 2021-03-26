variable "name" {

}

variable "user" {
  type = list(string)
  default = ["1","2","3","4"]
}

locals {
  arr     = ["val1", "val2"]
  number1 = 10
}

output "test" {
  value = var.user
}

output "test0" {
  value = var.user[0]
}


output "test1" {
  value = var.user[1]
}

output "test2" {
  value =var.user[2]
}

output "test3" {
  value = var.user[3]
}

output "test4" {
  value = element(var.user,4)
}

output "name-value"{
  value = var.name
}

variable "isBool" {
  type = bool
}

variable "ami_map" {
  type = map
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-fc0b939c"
  }
}

output "selected_ami" {
  value = var.ami_map["us-east-1"]
}