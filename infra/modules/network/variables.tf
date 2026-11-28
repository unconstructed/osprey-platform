variable "name" {
  description = "Name prefix for the VPC and its parts."
  type        = string
}

variable "cidr_block" {
  description = "VPC address range, a /16."
  type        = string
}
