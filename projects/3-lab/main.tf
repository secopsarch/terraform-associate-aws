locals {
  server_name = "websubnet-${var.env}"
  vpc_name    = "mydemovpc-${var.env}"
}
data "aws_region" "last-used" {}
data "aws_availability_zones" "available-az" {}

data "aws_ami" "websever" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-arm64"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_vpc" "lab_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name      = local.vpc_name
    terraform = "true"
    region    = data.aws_region.last-used.description
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.private_cidr
}
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.public_cidr
}
resource "aws_subnet" "web_subnet" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.web_cidr

  tags = {
    Name = local.server_name
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
}

resource "local_file" "ssh_private_key" {
  content = tls_private_key.ssh_key.private_key_pem
  filename = "labsshkey.pem"

}
resource "aws_spot_instance_request" "webserver" {
  ami           = data.aws_ami.websever.id
  instance_type = "t4g.nano"
  spot_price    = "0.05"

  tags = {
    Name = local.server_name
  }
}
