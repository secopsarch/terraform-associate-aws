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

# variable "private_subnets" {
#   description = "the private subnets in the VPC"
#   type = map(string)
#   default = {
#     "websubnet" = "10.16.1.0/24"
#     "dbsubnet" = "10.16.2.0/24"
#     "privatesubnet" = "10.16.50.0/24"
#   }
# }

# variable "public_subnets" {
#   description = "the public subnets in the VPC"
#   type = map(string)
#   default = {
#     "bastionsubnet" = "10.16.120.0/28"
#     "firewallsubnet" = "10.16.100.0/28"
#     "publicsubnet" = "10.16.200.0/28"
#   }
# }

# variable "subnets" {
#   description = "value for private and public subnets"
#   type = list(object({
#     private_subnets = string
#     public_subnets = string 
#   }))

#   default = [ {
#     "websubnet" = "10.16.1.0/24"
#     "dbsubnet" = "10.16.2.0/24"
#     "privatesubnet" = "10.16.50.0/24"
#   },
#   {
#     "bastionsubnet" = "10.16.120.0/28"
#     "firewallsubnet" = "10.16.100.0/28"
#     "publicsubnet" = "10.16.200.0/28"
#   } 
#   ]
# }


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