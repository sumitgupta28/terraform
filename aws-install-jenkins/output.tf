output "jenkins-server-public_ip" {
  value = aws_instance.jenkins-server.public_ip
}

output "jenkins-server-id" {
  value = aws_instance.jenkins-server.id
}
