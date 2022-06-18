### security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "nginx-sg" {
  name        = "masterclass-nginx-sg"
  vpc_id      = aws_vpc.main.id
  description = "Nginx SG"


  tags = {
    Name            = "masterclass-nginx-sg"
  }

}

# Allow access for port 80 from external lb sg(ext-alb)
resource "aws_security_group_rule" "allow_port80_from_ext_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ext-alb-sg.id
  security_group_id        = aws_security_group.nginx-sg.id
}

# Allow access for port 443 from external lb sg(ext-alb)
resource "aws_security_group_rule" "inbound-nginx-http" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ext-alb-sg.id
  security_group_id        = aws_security_group.nginx-sg.id
}