provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.2.2"
  backend "s3" {
    bucket = "devops-masterclass-chisom"
    key    = "terraformstate/terraform.tfstate"
    region = "us-east-1"
  }
}
