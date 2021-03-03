resource "aws_launch_configuration" "onlineportal-autoscale-launchconfig" {
  name_prefix     = "onlineportal-autoscale-launchconfig"
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.onlineportal-keypair.key_name
  security_groups = [aws_security_group.onlineportal-security-group-ssh.id,aws_security_group.onlineportal-security-group-tcp.id]
}

resource "aws_autoscaling_group" "onlineportal-autoscaling-group" {
  name                      = "onlineportal-autoscaling-group"
  vpc_zone_identifier       = [aws_subnet.onlineportal-pub-subnet-1.id, aws_subnet.onlineportal-pub-subnet-2.id]
  launch_configuration      = aws_launch_configuration.onlineportal-autoscale-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

