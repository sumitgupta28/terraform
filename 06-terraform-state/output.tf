output "front-end-arn" {
  value = aws_instance.front-end-server.arn
}

output "front-end-public_ip" {
  value = aws_instance.front-end-server.public_ip
}

output "back-end-arn" {
  value = aws_instance.back-end-server.arn
}

output "back-end-public_ip" {
  value = aws_instance.back-end-server.public_ip
}
