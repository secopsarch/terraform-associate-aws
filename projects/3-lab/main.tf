# Terraform Block
terraform {
  required_version = ">= 1.0.0"
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
  backend "s3" {
    bucket = "awslab-s3-arunbw"
    key    = "env/lab/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
provider "aws" {
  region = var.aws_region

}

locals {
  server_name = "websubnet-${var.env}"
  vpc_name = "mydemovpc-${var.env}"
}
resource "aws_vpc" "lab_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name      = local.vpc_name
    terraform = "true"
  }
}
resource "aws_subnet" "web-subnet" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.web_cidr

  tags = {
    Name = local.server_name
  }
}
