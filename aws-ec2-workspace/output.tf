output "front-end-tags" {
  value = aws_instance.front-end.tags
}

output "front-end-ami" {
  value = aws_instance.front-end.ami
}

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

output "back-end-ami" {
  value = aws_instance.back-end.ami
}


output "back-end-tags" {
  value = aws_instance.back-end.tags
}