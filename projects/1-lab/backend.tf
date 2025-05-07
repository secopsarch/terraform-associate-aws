# This file is used to configure the backend for Terraform state management.
terraform {
  backend "s3" {
    bucket         = "awslab-s3-arunbw"
    key            = "env/dev/main.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "sandbox-terraformlab-s3"
    encrypt        = true
  }
}

