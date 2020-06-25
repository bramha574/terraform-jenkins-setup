provider "aws" {
    region = var.region
    shared_credentials_file = "~/.aws/credentials"
}

terraform {
  backend "s3" {
    bucket         = "jenkins-terraform-setup-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "jenkins-state-locks"
    encrypt        = true
  }
}