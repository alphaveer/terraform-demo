module "vpc" {
  source  = "./modules/vpc"

  name     = "terraform-demo"
  vpc_cidr = "10.10.0.0/16"
}

output "vpc" {
  value = module.vpc
}
