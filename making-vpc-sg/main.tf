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

resource "aws_vpc" "name" {

  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
  
}

resource "aws_subnet" "private_subnet" {
  
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "private_subnet"
  }
}

resource "aws_security_group" "name" {
  vpc_id = aws_vpc.name.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lala"
  }
}

