variable "owner_email" {
  type    = string
  default = "ejimchisom@gmail.com"
}

variable "environment" {
  type = string
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
