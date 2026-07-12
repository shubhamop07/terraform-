terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.54.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


data "aws_vpc" "name" {

  tags = {
    Name = "my_vpc"
  }
  
}

data "aws_subnet" "private_subnet" {
  vpc_id = data.aws_vpc.name.id
  tags = {
    Name = "private_subnet"
  }
}

data "aws_security_group" "names" {

  tags = {
    Name = "lala"
  }

 
}



resource "aws_instance" "webserver" {
  ami = "ami-06259b63260eddc13"
  instance_type = "t3.micro"
  subnet_id = data.aws_subnet.private_subnet.id
  vpc_security_group_ids = [ data.aws_security_group.names.id ]
  tags = {
    Name = "checking"
  }
}