# variable declaration file
variable "aws_region" {
  description = "default region to create the resources"
  type        = string
  default     = "ap-southeast-1"
}
variable "env" {
  description = "name of the Environment "
  type        = string
  default     = "sandbox-dev"
}
variable "vpc_name" {
  description = "default name VPC to be created"
  type        = string
  default     = "mydemovpc"
}
variable "vpc_cidr" {
  description = "default vpc cidr block defined"
  type        = string
  default     = "10.10.0.0/16"
}
variable "web_cidr" {
  description = "default web cidr block defined"
  type        = string
  default     = "10.10.10.0/24"
}