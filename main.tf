locals {
  vpc_name = "${var.instance}-vpc"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = local.vpc_name

  cidr = var.vpc_cidr
  azs  = var.vpc_azs

  secondary_cidr_blocks = [var.vpc_secondary_cidr]

  private_subnets       = var.vpc_private_subnets
  private_subnet_suffix = "private-subnet"
  private_subnet_tags = {
    "Tier"                                    = "private"
    "kubernetes.io/cluster/${local.vpc_name}" = "shared"
    "kubernetes.io/role/internal-elb"         = "1"
  }

  public_subnets       = var.vpc_public_subnets
  public_subnet_suffix = "public-subnet"
  public_subnet_tags = {
    "Tier"                                    = "public"
    "kubernetes.io/cluster/${local.vpc_name}" = "shared"
    "kubernetes.io/role/elb"                  = "1"
  }

  intra_subnets       = var.vpc_intra_subnets
  intra_subnet_suffix = "intra-subnet"
  intra_subnet_tags = {
    "Tier" = "intra"
  }

  database_subnets       = var.vpc_database_subnets
  database_subnet_suffix = "database-subnet"
  database_subnet_tags = {
    "Tier" = "database"
  }

  create_database_subnet_group    = false
  create_elasticache_subnet_group = false
  create_redshift_subnet_group    = false

  map_public_ip_on_launch = false
  enable_dns_hostnames    = true
  enable_dns_support      = true
  enable_nat_gateway      = true
  single_nat_gateway      = false
  one_nat_gateway_per_az  = true
}
