# Terraform Settings block (HCL)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.10.0"
    }
  }
}

# Provider block
provider "aws" {
  # Configuration options
  region = "ap-south-1"
}