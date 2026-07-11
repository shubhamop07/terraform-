

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.54.0"
    }
  }

  backend "s3" {

    bucket = "lala-ki-bucket-216bbc143f6adaf9"
    key = "terraform.tfstate"
    region = "us-east-1"
    
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {

  ami = "ami-01edba92f9036f76e"
  instance_type = "t3.micro"

  tags = {
    Name = "changes with"
  }
  
}
