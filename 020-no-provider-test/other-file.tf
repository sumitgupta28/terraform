

locals {
  number2 = 10
}

output "sum" {
  value = local.number1 + local.number2
}