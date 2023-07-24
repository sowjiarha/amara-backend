resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "Bastion-host"
  }
}
resource "aws_security_group" "allow_tls" {
  name        = "SG_bastion"
  description = "SG for bastion host. SSH access only"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SG for bastion host. SSH access only"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
   /*egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = var.security_groups
  }*/
  tags = {
    Name = "SG-bastion"
  }
}
resource "aws_security_group_rule" "bastion-to-private-ssh-egress" {
    type = "egress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_group_id = "${aws_security_group.allow_tls.id}"
    source_security_group_id = var.security_groups
}
resource "aws_eip" "lb" {
}
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.lb.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "gw NAT"
  }
}

