terraform {
  backend "s3" {
    bucket         = "chetan-serverless-support-terraform-state"
    key            = "serverless-support-system/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
