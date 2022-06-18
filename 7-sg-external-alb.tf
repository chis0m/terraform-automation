### Create ext-alb-sg security group
resource "aws_security_group" "ext-alb-sg" {
  name        = "masterclass-ext-alb-sg"
  vpc_id      = aws_vpc.main.id
  description = "External ALB SG"


  tags = {
    Name            = "masterclass-ext-alb-sg"
  }

}


# Add security group rule for tcp:80
resource "aws_security_group_rule" "allow_all_ingress_port80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ext-alb-sg.id
}


resource "aws_security_group_rule" "allow_all_ext_alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ext-alb-sg.id
}