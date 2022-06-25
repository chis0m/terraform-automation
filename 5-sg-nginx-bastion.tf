### Continuation of 8-sgRule-nginx.tf
resource "aws_security_group_rule" "inbound-bastion-ssh-to-nginx" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion-sg.id
  security_group_id        = aws_security_group.nginx-sg.id
}


resource "aws_security_group_rule" "allow_all_nginx_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nginx-sg.id
}
