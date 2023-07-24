module "amara-backend-vpc" {
  source = "./modules/vpc"
}
module "amara-public-subnets" {
  source = "./modules/public-subnets"
  vpc_id = module.amara-backend-vpc.vpc_id
}
module "amara-private-subnets" {
  source = "./modules/private-subnets"
  vpc_id = module.amara-backend-vpc.vpc_id
  nacl_id = module.amara-public-subnets.nacl_id
  nat_gateway_id = module.amara-bastion-ec2.nat_gateway_id
}
module "amara-bastion-ec2" {
  source = "./modules/BastionHost"
  vpc_id = module.amara-backend-vpc.vpc_id
  subnet_id = module.amara-public-subnets.subnet_id 
  security_groups = module.amara-ec2-Prod-1.security_groups

}
module "amara-ec2-Prod-1" {
  source = "./modules/ec2-Prod-1"
  vpc_id = module.amara-backend-vpc.vpc_id
  subnet_id = module.amara-public-subnets.subnet_id
  security_groups = module.amara-bastion-ec2.security_groups
  cidr_blocks = module.amara-public-subnets.cidr_blocks
}

