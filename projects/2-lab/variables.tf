variable "resource_tags" {
  description = "defaul tags for all the resource created"
  type        = map(string)
  default = {
    dev      = "sandbox"
    resource = "terraform"
  }
}