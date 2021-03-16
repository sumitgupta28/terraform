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

#resource "aws_instance" "test_instance-1" {
#  ami           = "ami-0915bcb5fa77e4892" ## us-east-1
#  instance_type = "t2.micro"
#}