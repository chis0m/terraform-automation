module "network_module" {

  source = "github.com/chis0m/tf-network-module?ref=v1.0.3"

  base_name           = var.base_name
  env                 = var.env
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zones  = var.availability_zones
}

output "vpc_id" {
  value = module.network_module.vpc_id
}

output "public_subnet" {
  value = module.network_module.public_subnet
}

output "private_subnet" {
  value = module.network_module.private_subnet
}


