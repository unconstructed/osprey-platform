module "network" {
  source = "../../modules/network"

  name       = "osprey-dev"
  cidr_block = "10.10.0.0/16"
}

module "database" {
  source = "../../modules/database"

  name               = "osprey-dev"
  vpc_id             = module.network.vpc_id
  vpc_cidr           = module.network.vpc_cidr
  private_subnet_ids = module.network.private_subnet_ids

  # Dev: single zone, deletable, 1 day of backups (AWS free plan limit).
  # Prod: multi_az and deletion_protection true, 7+ days of backups.
  backup_retention_days = 1
  multi_az              = false
  deletion_protection   = false
}
