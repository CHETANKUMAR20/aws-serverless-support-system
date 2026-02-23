provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "chetan-serverless-support-terraform-state"

  tags = {
    Project = "TerraformBackend"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  server_side_encryption {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "state_bucket_block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
