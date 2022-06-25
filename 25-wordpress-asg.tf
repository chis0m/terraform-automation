resource "aws_autoscaling_group" "wordpress-asg" {
  name                      = format("%s%s%s", title(var.env), title(var.base_name), "-Wordpress-ASG")
  max_size                  = 0
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 0

  vpc_zone_identifier = [
    module.network_module.private_subnet["cidr_1"],
    module.network_module.private_subnet["cidr_2"]
  ]


  launch_template {
    id      = aws_launch_template.wordpress-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = format("%s%s%s", title(var.env), title(var.base_name), "-Wordpress-ASG")
    propagate_at_launch = true
  }

}
