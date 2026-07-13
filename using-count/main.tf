terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.54.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

locals {
  project = "project"
}

resource "aws_vpc" "my_vpc"{
 cidr_block ="10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "main"{
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.${count.index}.0/24"

  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

# making 4 ec2s

resource "aws_instance" "ec2" {

for_each = var.ec2_map
  
  ami = each.value.ami
  instance_type = each.value.instance_type

  subnet_id = element(aws_subnet.main[*].id , index(keys(var.ec2_map), each.key) % length(aws_subnet.main))
  
  tags = {
    Name = "${local.project}-ec2-${each.key}"
  }
}
