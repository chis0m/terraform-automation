### Create Private subnets
resource "aws_subnet" "PrivateSubnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "100.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name            = "PrivateSubnet-1"
  }

}


resource "aws_subnet" "PrivateSubnet-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "100.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name            = "PrivateSubnet-2"
  }

}

resource "aws_subnet" "PrivateSubnet-3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "100.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name            = "PrivateSubnet-3"
  }

}


resource "aws_subnet" "PrivateSubnet-4" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "100.0.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name            = "PrivateSubnet-4"
  }

}

resource "aws_subnet" "PrivateSubnet-5" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "100.0.7.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name            = "PrivateSubnet-5"
  }

}


resource "aws_subnet" "PrivateSubnet-6" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "100.0.8.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name            = "PrivateSubnet-6"
  }

}

### create route table for private subnet
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name            = "masterclass-Private-Route-Table"
  }
}


# create route for the private route table and attatch a nat gateway to it
resource "aws_route" "private-rtb-route" {
  route_table_id         = aws_route_table.private-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}


# associate all private subnets to the private route table
resource "aws_route_table_association" "private-subnets-assoc-1" {
  subnet_id      = aws_subnet.PrivateSubnet-1.id
  route_table_id = aws_route_table.private-rtb.id
}


resource "aws_route_table_association" "private-subnets-assoc-2" {
  subnet_id      = aws_subnet.PrivateSubnet-2.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-subnets-assoc-3" {
  subnet_id      = aws_subnet.PrivateSubnet-3.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-subnets-assoc-4" {
  subnet_id      = aws_subnet.PrivateSubnet-4.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-subnets-assoc-5" {
  subnet_id      = aws_subnet.PrivateSubnet-5.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-subnets-assoc-6" {
  subnet_id      = aws_subnet.PrivateSubnet-6.id
  route_table_id = aws_route_table.private-rtb.id
}
