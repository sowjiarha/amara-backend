output "nacl_id" {
  value = aws_network_acl.main.id
}
output "subnet_id" {
  value = aws_subnet.main.id 
}
output "cidr_blocks" {
  value = [var.pub_cidr]
}
