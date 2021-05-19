## Create a new application load balancer:
resource "aws_lb" "alb" {
  name            = "terraform-example-alb"
  security_groups = [aws_security_group.allow-ssh.id]
  subnets         = [aws_subnet.application-pub-subnet-us-east-1a.id, aws_subnet.application-pub-subnet-us-east-1b.id]

  tags = {
    "Name" = "New application load balancer"
  }

  depends_on = [
    aws_security_group.allow-ssh,
    aws_subnet.application-pub-subnet-us-east-1a,
    aws_subnet.application-pub-subnet-us-east-1b,
    aws_vpc.sgsys-application-vpc
  ]
}

output "aws_lb-url" {
  value = aws_lb.alb.dns_name
}

resource "aws_alb_target_group" "group" {
  name                          = "terraform-example-alb-target"
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = aws_vpc.sgsys-application-vpc.id
  load_balancing_algorithm_type = "round_robin"

  depends_on = [
    aws_lb.alb
  ]
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.group.arn
    type             = "forward"
  }

  depends_on = [
    aws_lb.alb,
    aws_alb_target_group.group
  ]
}


resource "aws_lb_target_group_attachment" "aws_lb_target_group_attachment-application-server-us-east-1a" {
  target_group_arn = aws_alb_target_group.group.arn
  target_id        = aws_instance.application-server-us-east-1a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "aws_lb_target_group_attachment-application-pub-subnet-us-east-1b" {
  target_group_arn = aws_alb_target_group.group.arn
  target_id        = aws_instance.application-pub-subnet-us-east-1b.id
  port             = 80
}