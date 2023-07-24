resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "private-prod-1"
  }
}
resource "aws_security_group" "allow_tls" {
  name        = "SG-private"
  description = "Security group for private subnet instances. Accept SSH inbound requests from Bastion host only"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Security group for private subnet instances. Accept SSH inbound requests from Bastion host only"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = var.security_groups

  }
  ingress {
    description      = "Security group for private subnet instances. Accept SSH inbound requests from Bastion host only"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks = var.cidr_blocks

  }

  tags = {
    Name = "SG-prod-1"
  }
}
