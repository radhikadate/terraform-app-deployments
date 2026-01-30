terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.24.0"
    }
  }
  
  backend "s3" {
    bucket         = "terraform-state-radhika-deployments"
    key            = "private-ec2-alb/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}
