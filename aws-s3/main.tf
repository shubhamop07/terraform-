
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.54.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}


resource "aws_s3_bucket" "demo_bucket" {
  bucket = "lala-ki-bucket-${random_id.rand_id.hex}"

}


resource "aws_s3_object" "bucket_data" {
  bucket = aws_s3_bucket.demo_bucket.id
  source = "./data.txt"
  key    = "data.txt"
}