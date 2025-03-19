terraform {
  backend "s3" {
    bucket         = "my-terraform-backend0303"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
  }
}