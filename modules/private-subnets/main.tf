resource "aws_subnet" "pri-sub" {
  vpc_id = var.vpc_id
  cidr_block = var.pri_cidr
  tags = {
    Name = "private-subnet-1"
  }
}
resource "aws_route_table" "private-r" {
  vpc_id = var.vpc_id
  tags = {
    Name = "private-routtable"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pri-sub.id
  route_table_id = aws_route_table.private-r.id
}
resource "aws_network_acl_association" "main" {
  network_acl_id = var.nacl_id
  subnet_id      = aws_subnet.pri-sub.id
}
resource "aws_route" "r" {
   route_table_id = aws_route_table.private-r.id
   destination_cidr_block = "0.0.0.0/0"
   nat_gateway_id = var.nat_gateway_id
}

