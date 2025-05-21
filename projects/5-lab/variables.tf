variable "aws_region" {
  description = "name of the region"
  type        = string
  default     = "ap-southeast-1"

}
variable "instance_type" {
  description = "type of instance or shape and size of instance used in the configuration"
  type        = map(any)
  default = {
    "prod" = "t2.medium"
    "dev"  = "t3.micro"
  }
}
variable "resource_tags" {
  description = "locals variable for creating tags"
  type        = tuple([string, number, bool])
  default     = ["sample", 4, false]

}

variable "web" {
  description = "number of web servers to be created"
  type        = list(any)
  default     = ["web1", "web2", "web3"]
}
/*

Input VARIABLES
-> string bool number map tuple list map(list), map(object), map(tuple)

Output values

*/