resource "aws_launch_configuration" "launchconfig" {
  name_prefix     = "launchconfig"
  image_id        = var.AS_AMI
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.myinstance.id]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling" {
  name                      = "autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  launch_configuration      = aws_launch_configuration.launchconfig.name
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  target_group_arns         = [aws_alb_target_group.test.arn]
  #load_balancers            = [aws_alb.my-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "Sridhar-AS-ec2"
    propagate_at_launch = true
  }
}

