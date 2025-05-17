# terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "= 3.1.1"
    }
  }
  backend "s3" {
    bucket = "awslab-s3-arunbw"
    key    = "env/lab/terraformlab.tfstate"
    region = "ap-southeast-1"
  }
}
provider "aws" {
  region = "ap-southeast-1"

}