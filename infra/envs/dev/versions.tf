terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # State bucket from infra/bootstrap. Backend blocks cannot use variables.
  backend "s3" {
    bucket       = "osprey-tfstate-558037577915"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    profile      = "osprey-dev"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "osprey-dev"

  default_tags {
    tags = {
      Project   = "osprey"
      Env       = "dev"
      ManagedBy = "terraform"
    }
  }
}
