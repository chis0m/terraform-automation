# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "datalayer-sg" {
  name        = "masterclass-datalayer-sg"
  vpc_id      = aws_vpc.main.id
  description = "Datalayer SG"


  tags = {
    Name            = "masterclass-datalayer-sg"
  }

}


resource "aws_security_group_rule" "allow_from_tooling_web_to_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.wordpress-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}


resource "aws_security_group_rule" "allow_from_wordpress_web_to_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tooling-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}



resource "aws_security_group_rule" "allow_from_tooling_web_to_efs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.wordpress-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}


resource "aws_security_group_rule" "allow_from_wordpress_web_to_efs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tooling-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}
