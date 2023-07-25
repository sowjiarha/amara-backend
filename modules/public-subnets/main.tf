resource "aws_subnet" "pub-sub" {
  vpc_id = var.vpc_id
  count = length(var.pub_cidr)
  cidr_block = var.pub_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-${count.index}"
  }
}
data "aws_availability_zones" "available" {}
resource "aws_route_table" "r" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-routetable"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.environment
  }
}
resource "aws_network_acl" "main" {
  vpc_id = var.vpc_id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
   egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "10.1.1.0/24"
    from_port  = 32768
    to_port    = 61000
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.1.1.0/24"
    from_port  = 22
    to_port    = 22
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name = "dev"
  }
}
