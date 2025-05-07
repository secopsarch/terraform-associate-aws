# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
#    null = {
#      source  = "hashicorp/null"
#      version = ">= 3.0"
#    }
  }
  backend "s3" {
    bucket         = "awslab-s3-arunbw"
    key            = "env/dev/main.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "sandbox-terraformlab-s3"
    encrypt        = true
  }
}
provider "aws" {
  # Configuration options
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "labcontainer" {
  bucket = "awslab-s3-arunbw"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "aws-lab"
    Environment = "sandbox"
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name     = "sandbox-terraformlab-s3"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "aws-lab"
    Environment = "sandbox"
  }
}
