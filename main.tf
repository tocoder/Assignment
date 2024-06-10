provider "aws" {
  region = var.region
}

module "tocoder_vpc" {

  source = "./vpc_module"
}