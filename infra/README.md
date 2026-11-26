# Infrastructure (Terraform, AWS us-east-1)

- `bootstrap/` - the S3 bucket that holds Terraform state for every other root. Run once; its own state is local.
- `envs/dev/` - the dev environment (later). Prod will be a separate AWS account.

Run from a root folder with the `osprey-dev` profile set up:

    terraform init
    terraform plan
    terraform apply   # only after the owner has seen the plan and said yes

Environments use the bucket like this (S3-native locking, no DynamoDB):

    backend "s3" {
      bucket       = "<state_bucket output>"
      key          = "dev/terraform.tfstate"
      region       = "us-east-1"
      encrypt      = true
      use_lockfile = true
    }
