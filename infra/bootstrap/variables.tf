variable "region" {
  description = "AWS region for the state bucket."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Local AWS CLI profile to use."
  type        = string
  default     = "osprey-dev"
}
