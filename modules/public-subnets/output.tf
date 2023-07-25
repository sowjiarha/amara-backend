output "nacl_id" {
  value = aws_network_acl.nacl.id
}
output "subnets" {
  value = aws_subnet.pub-sub.*.id
}
output "cidr_blocks" {
  #value = "${element(var.pub_cidr,count.index)}"
 # value = [for s in var.pub_cidr : s.cidr_block]
  value = ["10.1.1.0/24", "10.1.2.0/24"]
  #value = var.pub_cidr[count.index]
}
output "subnet_id" {
 # value = aws_subnet.pub-sub.*.id[count.0]
   value= "${element(aws_subnet.pub-sub.*.id, 0)}"
}
