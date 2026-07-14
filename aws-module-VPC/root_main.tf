provider "aws" {
  region = "eu-north-1"
}

module "vpc"{
  source = "./modules/vpc"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name = "my_vpc"
  }
  subnet_config = {
    "public_subnet" = {
      cidr_block = "10.0.0.0/24"
      az = "eu-north-1a"
      public = true
    } , 
    "private_subnet" = {
      cidr_block = "10.0.1.0/24"
      az = "eu-north-1b"
      
    }
  }
}
