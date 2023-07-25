resource "aws_subnet" "pri-sub" {
  vpc_id = var.vpc_id
  count = length(var.pri_cidr)
  cidr_block = var.pri_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "private-${count.index}"
  }
}
data "aws_availability_zones" "available" {}

resource "aws_route_table" "private-r" {
  vpc_id = var.vpc_id
  tags = {
    Name = "private-routetable"
  }
}
resource "aws_route_table_association" "a" {
  count = length(var.pri_cidr)
  subnet_id      = aws_subnet.pri-sub.*.id[count.index]
  route_table_id = aws_route_table.private-r.id
}
resource "aws_network_acl_association" "main" {
  count = length(var.pri_cidr)
  network_acl_id = var.nacl_id
  subnet_id      = aws_subnet.pri-sub.*.id[count.index]
}
resource "aws_route" "r" {
   route_table_id = aws_route_table.private-r.id
   destination_cidr_block = "0.0.0.0/0"
   nat_gateway_id = var.nat_gateway_id
}
