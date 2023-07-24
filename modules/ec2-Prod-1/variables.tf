variable "ami_id" {
  default = "ami-0f5ee92e2d63afc18"
}
variable "subnet_id" {
}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {
  default = "ec2-database"
}
variable "vpc_id" {
}
variable "security_groups" {
}
variable "cidr_blocks" {
}

