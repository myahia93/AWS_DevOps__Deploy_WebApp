module "network" {
  source = "./modules/network"

  __region            = var.region
  __vpc_cidr          = var.vpc_cidr
  __webapp_name       = var.webapp_name
  __snet_public_cidr  = var.snet_public_cidr
  __snet_private_cidr = var.snet_private_cidr
  __az                = var.az
}

module "nat" {
  source = "./modules/nat"

  __my_ip     = var.my_ip
  __nat_ami   = var.nat_ami
  __vpc_id    = module.network.vpc_id
  __subnet_id = module.network.public_subnets[0]
}

module "routing" {
  source = "./modules/routing"

  __vpc_id          = module.network.vpc_id
  __vpc_default_rt  = module.network.vpc_default_rt
  __snet_public_ids = module.network.public_subnets
  __igw_id          = module.network.igw_id
  __nat_eni_id      = module.nat.nat_eni
  __webapp_name     = var.webapp_name
}
