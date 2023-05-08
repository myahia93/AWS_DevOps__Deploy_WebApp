terraform {
  required_version = ">= 1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.14"
    }
    local = {
      version = "~>2.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
