output "onlineportal-eip-nat-public_ip" {
  value = aws_eip.onlineportal-eip.public_ip
}

output "onlineportal-nat-gw-public_ip" {
  value = aws_nat_gateway.onlineportal-nat-gw.public_ip
}

##onlineportal-front-end-server
output "onlineportal-front-end-server-public_ip" {
  value = aws_instance.onlineportal-front-end-server.public_ip
}

output "onlineportal-front-end-server-private_ip" {
  value = aws_instance.onlineportal-front-end-server.private_ip
}

output "onlineportal-front-end-server-arn" {
  value = aws_instance.onlineportal-front-end-server.arn
}

##onlineportal-bastion-host
output "onlineportal-bastion-host-public_ip" {
  value = aws_instance.onlineportal-bastion-host.public_ip
}

output "onlineportal-bastion-host-private_ip" {
  value = aws_instance.onlineportal-bastion-host.private_ip
}

output "onlineportal-bastion-host-arn" {
  value = aws_instance.onlineportal-bastion-host.arn
}


##onlineportal-back-end-server
output "onlineportal-back-end-server-private_ip" {
  value = aws_instance.onlineportal-back-end-server.private_ip
}

output "onlineportal-back-end-server-arn" {
  value = aws_instance.onlineportal-back-end-server.arn
}
