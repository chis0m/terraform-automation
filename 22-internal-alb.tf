# ----------------------------
#Internal Load Balancers for webservers
#---------------------------------

resource "aws_lb" "internal-alb" {
  name     = format("%s%s%s", title(var.env), title(var.base_name), "-Internal-ALB")
  internal = true

  security_groups = [aws_security_group.int-alb-sg.id]

  subnets = [
    module.network_module.private_subnet["cidr_1"],
    module.network_module.private_subnet["cidr_2"]
  ]
  tags = merge(local.tags,
  { Name = "project-15-internal-alb" })
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}


# --- target group  for wordpress -------

resource "aws_lb_target_group" "wordpress-tgt" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = format("%s%s%s", title(var.env), title(var.base_name), "-Wordpress-TGT")
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.network_module.vpc_id
}


# --- target group for tooling -------

resource "aws_lb_target_group" "tooling-tgt" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = format("%s%s%s", title(var.env), title(var.base_name), "-Tooling-TGT")
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.network_module.vpc_id
}

# For this aspect a single listener was created for the wordpress which is default,
# A rule was created to route traffic to tooling when the host header changes


resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.internal-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tgt.arn
  }
}

# listener rule for tooling target

resource "aws_lb_listener_rule" "tooling-listener" {
  listener_arn = aws_lb_listener.web-listener.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tooling-tgt.arn
  }

  condition {
    host_header {
      values = ["tooling.chisomejim.link"]
    }
  }
}


# listener rule for Wordpress target

resource "aws_lb_listener_rule" "wordpress-listener" {
  listener_arn = aws_lb_listener.web-listener.arn
  priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tgt.arn
  }

  condition {
    host_header {
      values = ["wordpress.chisomejim.link"]
    }
  }
}
