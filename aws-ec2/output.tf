output "front-end-arn" {
  value = aws_instance.front-end.arn
}

output "front-end-public_ip" {
  value = aws_instance.front-end.public_ip
}

output "back-end-arn" {
  value = aws_instance.back-end.arn
}

output "back-end-public_ip" {
  value = aws_instance.back-end.public_ip
}
