# data "aws_vpc" "default" {
#   default = true
# }

locals {
  name = var.resource_tags
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "labdemo-vpc"
  cidr = "192.168.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  public_subnets  = ["192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = var.resource_tags[0]


  }
}

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "lab_server" {
  count                  = length(var.web)
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type["prod"]
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
  tags = {
    Name = var.web[count.index]
  }
}
resource "aws_security_group" "demo_sg" {
  name        = "lab-web-sg"
  description = "Allow web inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.default_vpc_id
  ingress {
    description = "allow ssh to the server"
    from_port   = 22
    to_port     = 22
    protocol    = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow http to the server"
    from_port   = 80
    to_port     = 80
    protocol    = "http"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow https to the server"
    from_port   = 443
    to_port     = 443
    protocol    = "https"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow outbound to any the server"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow:http,https,ssh"
  }
}
