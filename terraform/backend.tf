terraform {
  backend "s3" {
    bucket         = "warehouse-manager-terraform-state-dev"
    key            = "dev/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}
