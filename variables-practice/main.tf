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

variable "instance_type" {

  type = string
  validation  {
    condition = var.instance_type == "t3.micro" || var.instance_type == "t2.micro"
    error_message = "Please select t3.micro or t2.micro"
  }

}

variable "ec2-config" {

  type = object({
    v_size = number
    v_type = string
  })

  default = {
    v_size = 20
    v_type = "gp2"
  }
  
}


resource "aws_instance" "webserver" {

  ami = "ami-01edba92f9036f76e"
  instance_type = var.instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2-config.v_size
    volume_type = var.ec2-config.v_type
  }

  tags = {
    Name = "webserver"
  }
}