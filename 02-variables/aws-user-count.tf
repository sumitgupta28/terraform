resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  count = 2
}

output "aws_iam_user_lb" {
  value = aws_iam_user.lb[*].name
}

resource "aws_iam_user" "lb-count" {
  name = "loadbalancer-${count.index}"
  count = 2
}


output "aws_iam_user_lb-count" {
  value = aws_iam_user.lb-count[*].name
}

resource "aws_iam_user" "lb-count-list" {
  name = var.elb-names[count.index]
  count = 2
}

variable "elb-names" {
  type = list
  default = ["dev-loadbalance","prod-loadbalance"]
}


output "aws_iam_user_lb-count-list-names" {
  value = aws_iam_user.lb-count-list[*].name
}