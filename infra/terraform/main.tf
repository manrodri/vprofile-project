terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
  profile = var.profile
}

provider "aws" {
  alias  = "cert"
  region = "us-east-1"
  profile = var.profile
}

