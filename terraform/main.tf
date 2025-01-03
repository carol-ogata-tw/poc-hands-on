provider "aws" {
  region = "sa-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0" #check
    }
  }
}

module "network" {
  source = "./network"
}

module "eks" {
  source              = "./eks"
  private-subnet-1-id = module.network.private-subnet-1-id
  private-subnet-2-id = module.network.private-subnet-2-id
  public-subnet-1-id  = module.network.public-subnet-1-id
  public-subnet-2-id  = module.network.public-subnet-2-id
}
