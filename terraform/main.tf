terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# موديول الشبكة: VPC, Subnets, IGW, NACL
module "network" {
  source      = "./modules/network"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

# موديول السيرفر: EC2 (Jenkins), Security Groups, CloudWatch
module "server" {
  source        = "./modules/server"
  vpc_id        = module.network.vpc_id
  subnet_id     = module.network.subnet_id
  instance_type = "t2.micro"             # ضيف السطر ده هنا عشان تجبره يكون مجاني
  ami_id        = "ami-04b70fa74e45c3917"
}
