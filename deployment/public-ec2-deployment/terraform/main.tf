    module "application_network" {
      source = "../../common-modules/network"
      cidr_block = "10.0.0.0/16"
      environment = var.environment
    }

    module "application_compute" {
      source = "../../common-modules/compute"
      
      environment = var.environment
      vpc_id      = module.application_network.vpc_id
      subnet_id   = module.application_network.public_subnet_id
      key_name    = var.key_name
    }
