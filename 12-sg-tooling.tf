# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "tooling-sg" {
  name        = format("%s%s%s", title(var.env), title(var.base_name), "-Tooling-SG")
  vpc_id      = module.network_module.vpc_id
  description = "tooling SG"

  tags = {
    Name = format("%s%s%s", title(var.env), title(var.base_name), "-Tooling-SG")
  }

}

resource "aws_security_group_rule" "allow_HTTP_from_internal_alb_to_tooling" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.int-alb-sg.id
  security_group_id        = aws_security_group.tooling-sg.id
}


resource "aws_security_group_rule" "inbound-bastion-ssh-to-tooling" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion-sg.id
  security_group_id        = aws_security_group.tooling-sg.id
}



resource "aws_security_group_rule" "allow_all_tooling_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tooling-sg.id
}

