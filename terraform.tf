# backend config (no variable suppport in backend config yet)
terraform {
  backend "s3" {
    bucket  = "avasoft-terraform-demo"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "alphav"
  }
}

# provider configuration
provider "aws" {
  region  = var.region
  profile = var.profile
}
