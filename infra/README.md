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

## Network and the NAT gateway

Dev has **no NAT gateway**, to save about $33 a month per zone (plus $0.045 per GB of traffic through it).
Private subnets have no route to the internet; a free S3 gateway endpoint lets them reach S3.

What that means in dev:
- **Database and Redis** sit in private subnets. They never call out to the internet, so they need no NAT.
- **App containers** (ECS) run in public subnets with a public IP, so they can pull images and call outside APIs.
  Security groups allow inbound traffic only from the load balancer. Each public IP costs about $3.60 a month.

**A NAT gateway (or VPC interface endpoints) becomes required when** any service must reach the internet from a
private subnet. That happens in **prod**: the trade router, chain watcher and workers belong in private subnets
but must call Privy, the RPC provider, 0x and the ramps. Budget one NAT gateway per zone in prod (about $66 a month
for two zones), or one shared NAT gateway (about $33) if a single-zone outage is acceptable for outbound calls.
Interface endpoints for ECR, Logs and Secrets Manager cost about $7 a month each per zone, so in our case they
are not cheaper than a NAT gateway.
