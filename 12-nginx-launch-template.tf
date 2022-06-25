# launch template for nginx

resource "aws_launch_template" "nginx-launch-template" {
  name = format("%s%s%s", title(var.env), title(var.base_name), "-NginxLaunchTemplate")

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }


  image_id = "ami-0f095f89ae15be883"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = "devops"


  monitoring {
    enabled = true
  }

  placement {
    availability_zone = var.availability_zones["az_1"]
  }


  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  tag_specifications {
    resource_type = "instance"


    tags = {
      Name = format("%s%s%s", title(var.env), title(var.base_name), "-NginxLaunchTemplate")
    }
  }

  user_data = filebase64("${path.module}/bin/nginx.sh")
}
