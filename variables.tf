variable "owner_email" {
  type    = string
  default = "ejimchisom@gmail.com"
}

variable "environment" {
  type    = string
  default = "dev"
}

locals {
  tags = {

    Enviroment      = var.environment
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "969933150232"
  }
  environment = var.environment

}

variable "base_name" {
  type = string

}

variable "env" {
  type = string

}

variable "vpc_cidr_block" {
  type = string

}

variable "public_subnet_cidr" {
  type = map(any)

}

variable "private_subnet_cidr" {
  type = map(any)

}


variable "availability_zones" {
  type = map(any)

}
