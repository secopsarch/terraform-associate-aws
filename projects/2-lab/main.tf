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
resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket-abw123"
  tags = {
    Name        = "My bucket"
    Environment = "demo_environment"
    Terraform   = "true" 
  }
  }
  resource "aws_security_group" "allow_tls" {
    name        = "allow_tls"
    description = "Allow TLS inbound traffic"
    vpc_id      = aws_vpc.vpc.id
    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  resource "aws_subnet" "websubnet" {
    name = "demo"
    subnet_id = aws_subnet.subnet_id
    vpc_id = aws_vpc.vpc_id
}
