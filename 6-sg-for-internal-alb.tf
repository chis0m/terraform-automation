# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "int-alb-sg" {
  name        = format("%s%s%s", title(var.env), title(var.base_name), "-InternalALB-SG")
  vpc_id      = module.network_module.vpc_id
  description = "Internal SG ALB"


  tags = {
    Name = format("%s%s%s", title(var.env), title(var.base_name), "-InternalALB-SG")
  }

}
