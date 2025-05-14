# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
}
# Provider Block
provider "aws" {
  region = "ap-southeast-1"
}
# Resource Block
resource "random_id" "randomness" {
  byte_length = 9
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket-abw123-${random_id.randomness.hex}"
  tags = {
    Name        = "My bucket"
    Environment = "demo_environment"
    Terraform   = "true" 
  }
}

resource "aws_s3_bucket_public_access_block" "allow_public_acls" {
  
  bucket = aws_s3_bucket.bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "versioning_configuration" {
  bucket = aws_s3_bucket.bucket.id 
 
  versioning_configuration {
    status = "Enabled"
  }
}


