module "onlineportal-autoscaling-group" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = "onlineportal-autoscaling-group"

  # Launch configuration
  lc_name = "onlineportal-autoscale-launchconfig"

  security_groups = [module.http-security-group.this_security_group_id, module.ssh-security-group.this_security_group_id]
  key_name        = aws_key_pair.onlineportal-keypair.key_name
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = var.INSTANCE_TYPE


  # Auto scaling group
  asg_name                  = "onlineportal-autoscaling-group"
  vpc_zone_identifier       = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  user_data                 = data.template_cloudinit_config.cloudinit-startup-script.rendered

  tags = [
    {
      key                 = "Environment"
      value               = "prod"
      propagate_at_launch = true
    },
    {
      key                 = "Terraform"
      value               = "true"
      propagate_at_launch = true
    },
  ]
}