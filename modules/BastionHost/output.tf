output "security_groups" {
  value = [aws_security_group.allow_tls.id]
}
output "nat_gateway_id" {
  value = aws_nat_gateway.example.id
}
