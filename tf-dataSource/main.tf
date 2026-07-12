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

data "aws_ami" "name"{
  most_recent = true
  owners = ["amazon"]
}

output "aws_ami" {

  value = data.aws_ami.name.id
  
}

resource "aws_instance" "webserver" {

  ami = "ami-01edba92f9036f76e"

  instance_type = "t3.micro"

  tags = {
    Name = "changes with"
  }
  
}