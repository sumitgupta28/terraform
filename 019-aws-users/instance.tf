variable "user_names" {
  description = "Create IAM users"
  type        = list(string)
  #default     = ["Peter", "Chris", "Stewie"]
  default     = ["Peter", "Brian"]
}
 
resource "aws_iam_user" "quiz_experts_user" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

resource "aws_instance" "test_instance-1" {
  ami           = "ami-0915bcb5fa77e4892" ## us-east-1 ami id
  instance_type = "t2.micro"
}

variable "users" {
  type    = list(string)
  default = ["Peter", "Lois", "Brian", "Meg"]
}
 
output "lucky_user" {
  value = element(var.users, 4)
}

variable "user_details" {
  type = object({ name = string, age = number })
}
 
output "user_details_output" {
  value = var.user_details
}

variable "input_number" {
  type    = number
  default = 1
}
 
output "magic_number" {
  value = var.input_number
}