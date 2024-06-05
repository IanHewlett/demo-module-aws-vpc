variable "instance" {
  type = string
}

variable "vpc_cidr" {
  description = "vpc CIDR"
  type        = string
}

variable "vpc_secondary_cidr" {
  description = "vpc secondary CIDR"
  type        = string
}

variable "vpc_azs" {
  description = "list of AZs for this VPC's subnets"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "list of public subnets"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "list of private subnets"
  type        = list(string)
}

variable "vpc_database_subnets" {
  description = "list of database subnets"
  type        = list(string)
}

variable "vpc_intra_subnets" {
  description = "list of intra subnets"
  type        = list(string)
}

variable "cluster_domain" {
  type = string
}
