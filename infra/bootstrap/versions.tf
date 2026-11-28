terraform {
  # 1.10+ is needed for S3-native state locking (use_lockfile), so no DynamoDB table.
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # This root keeps its own state locally (it creates the bucket the others use).
  # The file is git-ignored; if lost, re-import the bucket with `terraform import`.
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project   = "osprey"
      Component = "tf-bootstrap"
      ManagedBy = "terraform"
    }
  }
}
