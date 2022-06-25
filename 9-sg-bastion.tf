# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "bastion-sg" {
  name        = format("%s%s%s", title(var.env), title(var.base_name), "-Bastion-SG")
  vpc_id      = module.network_module.vpc_id
  description = "Bastion SG"

  tags = {
    Name = format("%s%s%s", title(var.env), title(var.base_name), "-Bastion-SG")
  }

}


resource "aws_security_group_rule" "allow_SSH_from_my_public_ip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["154.120.92.53/32"]
  security_group_id = aws_security_group.bastion-sg.id
}


resource "aws_security_group_rule" "allow_all_bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion-sg.id
}


resource "aws_security_group_rule" "allow_SSH_from_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion-sg.id
}
