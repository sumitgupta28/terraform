output "aws_eip-nat-public_ip" {
  value = aws_eip.nat.public_ip
}

output "aws_nat_gateway-nat-gw-public_ip" {
  value = aws_nat_gateway.nat-gw.public_ip
}

output "application-server-public_ip" {
  value = aws_instance.application-server.public_ip
}

output "application-server-private_ip" {
  value = aws_instance.application-server.private_ip
}

output "application-server-arn" {
  value = aws_instance.application-server.arn
}

output "rds" {
  value = aws_db_instance.mariadb.endpoint
}
