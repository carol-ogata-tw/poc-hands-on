provider "aws" {
  region = "sa-east-1"
}

module "network" {
  source = "./network"
}

module "sg" {
  source = "./sg"
  vpc_id = module.network.vpc_id
}

module "ec2" {
  source = "./ec2"
  subnet = module.network.subnet_id
  sg_id  = module.sg.sg_id
}

output "public_ip" {
  value = module.ec2.public_ip
}