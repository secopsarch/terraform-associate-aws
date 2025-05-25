# Resource Block
locals {
  name = var.resource_tags
}

resource "random_id" "randomness" {
  byte_length = 9
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket-abw123-${random_id.randomness.hex}"
  tags   = merge(local.name, { workspace = terraform.workspace })
}

resource "aws_s3_bucket_public_access_block" "allow_public_acls" {

  bucket                  = aws_s3_bucket.bucket.id
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

module "vpclab" {
  source = "./modules/vpc"

}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  name = "spot-instance"

  create_spot_instance = true
  spot_price           = "0.60"
  spot_type            = "persistent"

  instance_type          = "t2.micro"
  key_name               = "labkey01"
  monitoring             = true
  vpc_security_group_ids = ["sg-00637f85dc6eb843f"]
  subnet_id              = module.vpclab.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}