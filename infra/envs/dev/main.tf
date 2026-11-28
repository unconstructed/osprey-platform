module "network" {
  source = "../../modules/network"

  name       = "osprey-dev"
  cidr_block = "10.10.0.0/16"
}
