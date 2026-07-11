

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.54.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "webserver" {

  ami = "ami-0aba19e56f3eaec05"
  instance_type = var.instance_type

  tags = {
    Name = "changes with"
  }
  
}
