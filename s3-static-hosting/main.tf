
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


resource "aws_s3_bucket" "mywebapp_bucket" {
  bucket = "hosting-ki-bucket-${random_id.rand_id.hex}"

}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mywebapp_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp" {

  bucket = aws_s3_bucket.mywebapp_bucket.id
  policy = jsonencode(
    {
  Version =  "2012-10-17",
  Statement= [
    {
      Sid= "PublicReadGetObject",
      Effect= "Allow",
      Principal= "*",
      Action= "s3:GetObject"  ,
      Resource = "arn:aws:s3:::${aws_s3_bucket.mywebapp_bucket.id}/*"
      
    }
  ]
}   
  )
  
}

resource "aws_s3_object" "index_data" {
  bucket = aws_s3_bucket.mywebapp_bucket.id
  source = "./index.html"
  key    = "index.html"
  content_type = "text/html"
}
resource "aws_s3_object" "style_data" {
  bucket = aws_s3_bucket.mywebapp_bucket.id
  source = "./style.css"
  key    = "style.css"
  content_type = "text/css"
}

resource "aws_s3_bucket_website_configuration" "myweb" {
  bucket = aws_s3_bucket.mywebapp_bucket.id

  index_document {
    suffix = "index.html"
  }
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.myweb.website_endpoint
}