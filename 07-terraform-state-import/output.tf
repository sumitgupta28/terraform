output "front-end-arn" {
  value = aws_instance.ec2-server.arn
}

output "front-end-public_ip" {
  value = aws_instance.ec2-server.public_ip
}

